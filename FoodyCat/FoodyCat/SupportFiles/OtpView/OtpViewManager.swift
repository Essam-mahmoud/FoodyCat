//
//  OtpViewManager.swift
//  Elagk
//
//  Created by macintosh on 4/8/20.
//  Copyright © 2020 Modawa. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class OTPView: UIView {
    
    private var stackView = UIStackView()
    var fields = [OTPTextField]()
    
    @IBInspectable
    var numberOfFields: Int = 4
    
    @IBInspectable
    var placeholderChar: String = ""
    
    @IBInspectable
    var fieldSpacing: CGFloat = 10 {
        didSet{
            stackView.spacing = fieldSpacing
        }
    }
    
    @IBInspectable
    var fieldBackgroundColor: UIColor = UIColor(displayP3Red: 77/255, green: 75/255, blue: 130/255, alpha: 0.8)
    
    open var onSuccessCodeEnter: ((_ code: String)->Void)?
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        initilize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initilize()
    }
    
    func initilize() {
        
        let requiredFieldBoxSize = bounds.width - (CGFloat(numberOfFields)*fieldSpacing)
        assert(requiredFieldBoxSize > fieldSpacing, "Pin text box area should be greater than 'fieldSpacing' property value")
        stackView.removeFromSuperview()
        addSubview(stackView)
        stackView.anchorAllEdgesToSuperview()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = fieldSpacing
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: fieldSpacing, bottom: 0, right: fieldSpacing)
        stackView.isLayoutMarginsRelativeArrangement = true
        fields.removeAll()
        for _ in 0...numberOfFields {
            let field = OTPTextField()
//            field.borderStyle = .
            field.layer.masksToBounds = true
            field.layer.borderWidth = CGFloat(1.0)
            field.layer.borderColor =  UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
            field.layer.cornerRadius = 10
            field.placeholder = placeholderChar
            field.keyboardType = .phonePad
            field.backgroundColor = fieldBackgroundColor
            field.textAlignment = .center
            field.textColor = UIColor(displayP3Red: 25/255, green: 25/255, blue: 52/255, alpha: 1)
            stackView.addArrangedSubview(field)
            stackView.semanticContentAttribute = .forceLeftToRight

            fields.append(field)

//            fields.appearance().semanticContentAttribute = .forceLeftToRight

        }
        
        for (index, item) in fields.enumerated() {
            item.fields = fields
            if index == numberOfFields{
                item.completion = { passCode in
                    if let lCompletion = self.onSuccessCodeEnter{
                        lCompletion(passCode)
                    }
                }
            }
        }
    }
}


extension UIView {
    
    fileprivate func anchorAllEdgesToSuperview() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        for attribute : NSLayoutConstraint.Attribute in [.left, .top, .right, .bottom] {
            anchorToSuperview(attribute: attribute)
            
        }
    }
    
    fileprivate func anchorToSuperview(attribute: NSLayoutConstraint.Attribute) {
        addSuperviewConstraint(constraint: NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: superview, attribute: attribute, multiplier: 1.0, constant: 0.0))
    }
    
    fileprivate func addSuperviewConstraint(constraint: NSLayoutConstraint?) {
        guard let lConstraint = constraint else { return }
        superview?.addConstraint(lConstraint)
    }
}
