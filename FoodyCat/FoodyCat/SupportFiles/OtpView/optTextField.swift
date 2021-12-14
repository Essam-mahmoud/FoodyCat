//
//  optTextField.swift
//  Elagk
//
//  Created by macintosh on 4/8/20.
//  Copyright © 2020 Modawa. All rights reserved.
//

import Foundation
import UIKit

class OTPTextField: UITextField, UITextFieldDelegate {
    
    open var fields: [OTPTextField]?
    
    open var completion: ((_ code: String)->Void)?
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    init() {
        super.init(frame: .zero)
        initilize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initilize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initilize()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initilize()
    }
    
    private func initilize() {
        delegate = self
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        respondPrevious(field: self)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string.count > 0 else {
            return true
        }
        
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let change = prospectiveText.count == 1
        if change{
            textField.text = prospectiveText
            respondNext(field: self)
        }
        
        return change
    }
    
    func respondNext(field: OTPTextField) {
        guard let lFields = fields else {
            return
        }
        
        guard let index = lFields.index(of: field) else{
            return
        }
        
        if index == lFields.count-1 {
            var passCode = ""
            for item in lFields {
                passCode = passCode + item.text!
            }
            if let lCompletion = completion {
                lCompletion(passCode)
            }
            field.resignFirstResponder()
            return
        }
        
        lFields[index+1].becomeFirstResponder()
    }
    
    func respondPrevious(field: OTPTextField) {
        guard let lFields = fields else {
            return
        }
        
        guard let index = lFields.index(of: field) else{
            return
        }
        
        if index == 0 {
            return
        }
        
        lFields[index-1].becomeFirstResponder()
    }
    
    
}
