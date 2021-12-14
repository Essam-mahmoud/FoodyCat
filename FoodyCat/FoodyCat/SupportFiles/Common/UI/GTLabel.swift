//
//  GTLabel.swift
//  Duty
//
//  Created by Mohamed Ismail on 6/7/18.
//  Copyright © 2018 GreenTech. All rights reserved.
//

import UIKit

@IBDesignable
class GTSearchBar: UISearchBar {
    var currentTextField : UITextField? {
        get{
            return subviews.first?.subviews.filter({$0 is UITextField}).first as? UITextField
        }
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        GTTextField.setCustomFontFor(txtField: currentTextField ?? UITextField())
        currentTextField?.textColor = .lightGray
        currentTextField?.font = LanguageManager.getLocalizedFont(fontSize: 12)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        updateAlignmentUI()
        GTTextField.setCustomFontFor(txtField: currentTextField ?? UITextField())

    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        GTTextField.setCustomFontFor(txtField: currentTextField ?? UITextField())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func updateAlignmentUI(){
        if self.currentTextField?.textAlignment == .natural {
            self.currentTextField?.textAlignment = Util.UI.getTextAlignment()
        }
    }
    

}
@IBDesignable
class GTLabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        updateAlignmentUI()
        GTLabel.setCustomFontFor(label: self)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        GTLabel.setCustomFontFor(label: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func truncateOnTwoLinesAndAhalf(){
        let arrString =  getLinesArrayOfString()
        if arrString.count >= 3{
            var normaliedText = arrString.first ?? ""
            normaliedText = normaliedText + (arrString[1] )
            if (arrString[2].count) < Int(arrString[1].count / 2) {
                normaliedText = normaliedText + (arrString[2] )
            }else {
                var lastLine = arrString[2]
                lastLine = String(lastLine.prefix(Int(arrString[1].count / 2) ))
                normaliedText = normaliedText + lastLine
            }
            text = normaliedText + ".."
            
        }
    }
    func countLabelLines() -> Int {
        // Call self.layoutIfNeeded() if your view uses auto layout
        let myText = (self.text) ?? ""
        
        let rect = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font ?? ""], context: nil)
        
        return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
    }
   
    func getLinesArrayOfString() -> [String] {
        
        /// An empty string's array
        var linesArray = [String]()
        
        guard let text = self.text, let font = self.font else {return linesArray}
        
        let rect = self.frame
        
        let myFont: CTFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        let attStr = NSMutableAttributedString(string: text)
        attStr.addAttribute(kCTFontAttributeName as NSAttributedString.Key, value: myFont, range: NSRange(location: 0, length: attStr.length))
        
        let frameSetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attStr as CFAttributedString)
        let path: CGMutablePath = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: rect.size.width, height: 100000), transform: .identity)
        
        let frame: CTFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        guard let lines = CTFrameGetLines(frame) as? [Any] else {return linesArray}
        
        for line in lines {
            let lineRef = line as! CTLine
            let lineRange: CFRange = CTLineGetStringRange(lineRef)
            let range = NSRange(location: lineRange.location, length: lineRange.length)
            let lineString: String = (text as NSString).substring(with: range)
            linesArray.append(lineString)
        }
        return linesArray
    }

    class func setCustomFontFor(label:UILabel){
        let size  = label.font.pointSize
        if LanguageManager.isArabic() {
            let fontName = label.font.isBold ? LanguageManager.Font.ARABIC_FONT_BOLD : LanguageManager.Font.ARABIC_FONT_REGULAR
            label.font = UIFont.init(name: fontName, size: size)
        }else {
            let fontName = label.font.isBold ? LanguageManager.Font.ENGLISH_FONT_BOLD : LanguageManager.Font.ENGLISH_FONT_REGULAR
            label.font = UIFont.init(name: fontName, size: size)
        }
    }
    
    func updateAlignmentUI(){
        if self.textAlignment == .natural {
            self.textAlignment = Util.UI.getTextAlignment()
        }
    }
    
    
    @IBInspectable var localizedText: String = ""{
        didSet{
            text = localizedText.localized()
        }
        
    }
    @IBInspectable var roundIt: Bool = false  {
        didSet{
            if roundIt {
                layer.cornerRadius = frame.height / 2
                //                layer.masksToBounds = (frame.height / 2) > 0
                
            }
        }
    }
}
extension UILabel {

    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
        let readMoreText: String = trailingText + moreText

        let lengthForVisibleString: Int = self.vissibleTextLength
        let mutableString: String = self.text!
        let trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: ((self.text?.count)! - lengthForVisibleString)), with: "")
        let readMoreLength: Int = (readMoreText.count)
        let trimmedForReadMore: String = (trimmedString! as NSString).replacingCharacters(in: NSRange(location: ((trimmedString?.count ?? 0) - readMoreLength), length: readMoreLength), with: "") + trailingText
        let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: self.font ?? ""])
        let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
        answerAttributed.append(readMoreAttributed)
        self.attributedText = answerAttributed
    }

    var vissibleTextLength: Int {
        let font: UIFont = self.font
        let mode: NSLineBreakMode = self.lineBreakMode
        let labelWidth: CGFloat = self.frame.size.width
        let labelHeight: CGFloat = self.frame.size.height
        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)

        let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: font]
        let attributedText = NSAttributedString(string: self.text!, attributes: attributes as? [NSAttributedString.Key : Any])
        let boundingRect: CGRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)

        if boundingRect.size.height > labelHeight {
            var index: Int = 0
            var prev: Int = 0
            let characterSet = CharacterSet.whitespacesAndNewlines
            repeat {
                prev = index
                if mode == NSLineBreakMode.byCharWrapping {
                    index += 1
                } else {
                    index = (self.text! as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: self.text!.count - index - 1)).location
                }
            } while index != NSNotFound && index < self.text!.count && (self.text! as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedString.Key : Any], context: nil).size.height <= labelHeight
            return prev
        }
        return self.text!.count
    }
}
