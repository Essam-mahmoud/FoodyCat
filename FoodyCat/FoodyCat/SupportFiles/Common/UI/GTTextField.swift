//
//  GTTextField.swift
//  Duty
//
//  Created by Mohamed Ismail on 6/7/18.
//  Copyright © 2018 GreenTech. All rights reserved.
//

import UIKit
import UITextView_Placeholder
class GTTextField:UITextField {
    
     // MARK: - Variable
    var validClosure: (String?,Bool) -> () = { _,_   in }
    var validationType = validationTypes.email
    var matchString : String? = nil
    var textChangeClosure: (String) -> () = { _ in }
    
    // MARK: - Function
    func validateEmail(_ textField: UITextField) {
        
        if AppCommon.sharedInstance.isValidEmail(txtString: text ?? "") {
//            self.borderColor = UIColor.textBorder
            self.validClosure(text,true)
        }else{
//            self.borderColor = UIColor.red
            self.validClosure(nil,false)
        }
    }
    
    func bind(type:validationTypes,matchString:String?=nil,callback: @escaping (String?,Bool) -> ()) {
        
        self.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
        self.validationType = type
        self.matchString = matchString
        self.validClosure = callback
    }
    private func commonInit() {
        self.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
    }
    
    @objc func textFieldChange(_ textField: UITextField) {
        switch self.validationType {
        case .mobile:
            validateMobile(textField)
        case .email:
            validateEmail(textField)
        case .password:
            validatePassword(textField)
        case .IDNumber:
            validateIDNumber(textField)
        case .matchString:
            matchString(textField)
        case .emptyString:
            validateIsEmpty(textField)
        default:
            break
        }
        
    }
    func validateMobile(_ textField: UITextField) {
        if let text = textField.text ,text.count == 9, text.hasPrefix("5") {
//            self.borderColor = UIColor.textBorder
            self.validClosure(text,true)
        }else{
//            self.borderColor = UIColor.red
            self.validClosure(nil,false)
        }
    }
    func validatePassword(_ textField: UITextField) {
        if let text =  textField.text,text.count  >= 6 {
//            self.borderColor = UIColor.textBorder
            self.validClosure(text,true)
        }else{
//            self.borderColor = UIColor.red
            self.validClosure(nil,false)
        }
        
    }
    
    func validateIDNumber(_ textField: UITextField) {
        if let text =  textField.text,text.count == 10 {
            self.validClosure(text,true)
        }else{
            self.validClosure(nil,false)
        }
    }
    
    func matchString(_ textField: UITextField) {
        
        print(text ,matchString)
        if text == matchString && matchString != nil {
//            self.borderColor = UIColor.textBorder
            self.validClosure(text,true)
        }else{
//            self.borderColor = UIColor.red
            self.validClosure(nil,false)
        }
        
    }
    
    func validateIsEmpty(_ textField: UITextField) {
        let text = textField.text ?? ""
        if  text != "" {
//            self.borderColor = UIColor.textBorder
            self.validClosure(text,true)
        }else{
//            self.borderColor = UIColor.red
            self.validClosure(nil,false)
        }
    }
    
    override var placeholder: String?{
        didSet{
            if let text = placeholder{
                attributedPlaceholder = NSAttributedString(string: text,
                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x8E8E93)])
            }
            textAlignment = LanguageManager.isArabic() ? .right : .left
        }
        
    }
    var onDoneBtn : ActionBlock?
    override func awakeFromNib() {
        super.awakeFromNib()
        updateAlignmentUI()
        configureUI()
        GTTextField.setCustomFontFor(txtField: self)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        commonInit()
        GTTextField.setCustomFontFor(txtField: self)
    }
    func configureUI(){
        
    }
    @objc func dismissBtn(){
        onDoneBtn?()
        resignFirstResponder()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        commonInit()
    }
    
    class func setCustomFontFor(txtField:UITextField){
        let size  = txtField.font?.pointSize
        if LanguageManager.isArabic() {
            let fontName = (txtField.font?.isBold)! ? LanguageManager.Font.ARABIC_FONT_BOLD : LanguageManager.Font.ARABIC_FONT_REGULAR
            txtField.font = UIFont.init(name: fontName, size: size!)
        }else {
            let fontName = (txtField.font?.isBold)! ? LanguageManager.Font.ENGLISH_FONT_BOLD : LanguageManager.Font.ENGLISH_FONT_REGULAR
            txtField.font = UIFont.init(name: fontName, size: size!)
        }
    }
    func updateAlignmentUI(){
        if self.textAlignment == .natural {
            self.textAlignment = Util.UI.getTextAlignment()
        }
    }
    var isEmpty:Bool{
        if text?.count == 0 {
            return true
        }
        return false
    }
    
    @IBInspectable var localizedText: String = ""{
        didSet{
            text = localizedText.localized()
        }
        
    }
    
    @IBInspectable var localizedPlaceHolder: String = ""{
        didSet{
            self.placeholder = localizedPlaceHolder.localized()
        }
        
    }
    
}
extension UITextField {
    
       @IBInspectable var placeHolderColor: UIColor? {
            get {
                return self.placeHolderColor
            }
            set {
                self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
            }
        }
   
    enum PaddingSpace {
        case left(CGFloat)
        case right(CGFloat)
        case equalSpacing(CGFloat)
    }
    
    func addPadding(padding: PaddingSpace) {
        
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        
        switch padding {
            
        case .left(let spacing):
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = leftPaddingView
            self.leftViewMode = .always
            
        case .right(let spacing):
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = rightPaddingView
            self.rightViewMode = .always
            
        case .equalSpacing(let spacing):
            let equalPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = equalPaddingView
            self.leftViewMode = .always
            // right
            self.rightView = equalPaddingView
            self.rightViewMode = .always
        }
    }
}
