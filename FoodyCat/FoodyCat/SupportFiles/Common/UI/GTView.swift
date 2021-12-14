//
//  UIView+Extension.swift
//  Duty
//
//  Created by Mohamed Ismail on 6/7/18.
//  Copyright © 2018 GreenTech. All rights reserved.
//
import UIKit

extension UIView {
    
  
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
//            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = shadowRadius
        }
    }
    
}
@IBDesignable
class GTTabBarItem: UITabBarItem{
    override func awakeFromNib() {
        super.awakeFromNib()
        GTTabBarItem.setCustomFontFor(item: self)
    }
    class func setCustomFontFor(item:GTTabBarItem){
        item.setTitleTextAttributes([NSAttributedString.Key.font: LanguageManager.getLocalizedFont(fontSize: 12)], for: .normal)
    }
    @IBInspectable var localizedTitle: String = "" {
        didSet{
            title = localizedTitle.localized()
        }
    }
    
}
@IBDesignable
class GTView: UIView{
//    func showAlert(title:String = "Message".localized(),message:String){
//        BannerView.showAlert(message: message, colorCode: .failure)
//    }
    //MARK:- Loading indicator
    @IBInspectable var dashWidth: CGFloat = 0
       @IBInspectable var dashColor: UIColor = .clear
       @IBInspectable var dashLength: CGFloat = 0
       @IBInspectable var betweenDashesSpace: CGFloat = 0
    
    var dashBorder: CAShapeLayer?

       override func layoutSubviews() {
           super.layoutSubviews()
           dashBorder?.removeFromSuperlayer()
           let dashBorder = CAShapeLayer()
           dashBorder.lineWidth = dashWidth
           dashBorder.strokeColor = dashColor.cgColor
           dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
           dashBorder.frame = bounds
           dashBorder.fillColor = nil
           if cornerRadius > 0 {
               dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
           } else {
               dashBorder.path = UIBezierPath(rect: bounds).cgPath
           }
           layer.addSublayer(dashBorder)
           self.dashBorder = dashBorder
       }
    
    @IBInspectable var dropShadow: Bool = false  {
        didSet{
            if dropShadow {
                layer.shadowOffset = CGSize(width: 0, height: 0)
                layer.shadowColor = UIColor.gray.cgColor
                layer.shadowRadius = 4
                layer.shadowOpacity = 0.70
                let shadowFrame: CGRect? = layer.bounds
                let shadowPath = UIBezierPath(rect: shadowFrame ?? CGRect.zero).cgPath
                superview?.layer.shadowPath = shadowPath
                if layer.cornerRadius == 0 {
                    layer.cornerRadius = 3
                }
                
            }
        }
    }
    
    @IBInspectable var roundTop: CGFloat = 0.0  {
        didSet{
            if roundTop != 0.0 {
                layer.cornerRadius = roundTop
                layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            }
            
        }
    }

    @IBInspectable var roundBottom: CGFloat = 0.0  {
        didSet{
            if roundBottom != 0.0 {
                layer.cornerRadius = roundBottom
                layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
            }
            
        }
    }
   
    @IBInspectable var dropShadowWithColor: UIColor = UIColor.clear {
        didSet{
            if dropShadow {
                layer.shadowOffset = CGSize(width: 0, height: 0)
                layer.shadowColor = dropShadowWithColor.cgColor
                layer.shadowRadius = 4
                layer.shadowOpacity = 0.70
                let shadowFrame: CGRect? = layer.bounds
                let shadowPath = UIBezierPath(rect: shadowFrame ?? CGRect.zero).cgPath
                superview?.layer.shadowPath = shadowPath
                if layer.cornerRadius == 0 {
                    layer.cornerRadius = 3
                }
                
            }
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

@IBDesignable
class GTImageView: UIImageView{
    @IBInspectable var dropShadow: Bool = false  {
        didSet{
            if dropShadow {
                layer.shadowOffset = CGSize(width: 0, height: 0)
                layer.shadowColor = UIColor.gray.cgColor
                layer.shadowRadius = 3
                layer.shadowOpacity = 0.50
                let shadowFrame: CGRect? = layer.bounds
                let shadowPath = UIBezierPath(rect: shadowFrame ?? CGRect.zero).cgPath
                superview?.layer.shadowPath = shadowPath
                layer.cornerRadius = 3
                
            }
        }
    }
    
    
    @IBInspectable var roundIt: Bool = false  {
        didSet{
            if roundIt {
                layer.cornerRadius = frame.width / 2
                layer.masksToBounds = (frame.width / 2) > 0
                
            }
        }
    }
    @IBInspectable
    var localizedBackgroundImage: String = ""{
        didSet{
            image = UIImage(named: localizedBackgroundImage.localized())
        }
    }
    
}

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var FirstColor:UIColor = UIColor.clear {
        didSet {
            updateView()
        }
        
    }
    
    @IBInspectable var SecondColor:UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    @IBInspectable var gradientLocation:Double = 0.5 {
        didSet {
            updateView()
        }
    }
    override class var layerClass : AnyClass{
        get{
            return CAGradientLayer.self
        }
    }
    
    func updateView(){
        let layer = self.layer as! CAGradientLayer
        layer.colors = [FirstColor.cgColor,SecondColor.cgColor]
        layer.locations = [NSNumber(floatLiteral: gradientLocation)]
    }
    func makeHorizontalGradient(){
        let layer = self.layer as! CAGradientLayer
        let firstColor = UIColor.white
        let secondColor = UIColor(white: 1, alpha: 0.0)
        layer.startPoint = LanguageManager.isArabic() ? CGPoint(x: 1.0, y: 0.5) : CGPoint(x: 0, y: 0.5)
        layer.endPoint = LanguageManager.isArabic() ? CGPoint(x: 0, y: 0.5) : CGPoint(x: 1.0, y: 0.5)
        layer.colors = [firstColor.cgColor,secondColor.cgColor]
        layer.locations = [0.0,1]

    }
}


@IBDesignable
class MZNavigationBar: UINavigationBar{
    
    @IBInspectable var upgradeStyle: Bool = false  {
        didSet{
            if upgradeStyle{
                barTintColor = Util.UI.APP_COLOR
                shadowImage = UIImage()
                setBackgroundImage(UIImage(), for: .default)
                isTranslucent = false
                barStyle = .default
                backgroundColor = UIColor.clear
                
                titleTextAttributes = [NSAttributedString.Key.font: LanguageManager.getLocalizedFont(), NSAttributedString.Key.foregroundColor:Util.UI.APP_TINT_COLOR]
                UIBarButtonItem.appearance().setTitleTextAttributes(
                    [NSAttributedString.Key.font: LanguageManager.getLocalizedFont(), NSAttributedString.Key.foregroundColor:Util.UI.APP_TINT_COLOR], for: .normal)
                titleTextAttributes = [NSAttributedString.Key.font: LanguageManager.getLocalizedFont(), NSAttributedString.Key.foregroundColor:Util.UI.APP_TINT_COLOR]
            }
        }
    }
    

}

extension UICollectionViewFlowLayout {
    
    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return LanguageManager.isArabic()
    }
}

extension UIApplication {
    
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        
        return viewController
    }
}

extension DispatchQueue {
    static func executeOnMainThread(_ closure: @escaping ActionBlock) {
        if Thread.isMainThread {
            closure()
        } else {
            main.async {
                closure()
            }
        }
    }
}
@IBDesignable
class CardView: UIView {
    
    @IBInspectable var _cornerRadius: CGFloat = 5
    @IBInspectable var _borderWidth: Float = 0.0
    @IBInspectable var _bordercolor: UIColor? = UIColor.gray
    @IBInspectable var shadowOffsetWidth: Int = 2
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var _shadowColor: UIColor? = UIColor.gray
    @IBInspectable var _shadowOpacity: Float = 0.16
    
    override func layoutSubviews() {
        layer.cornerRadius = _cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: _cornerRadius)
        layer.masksToBounds = false
        layer.borderWidth = CGFloat(_borderWidth)
        layer.borderColor = _bordercolor?.cgColor
        layer.shadowColor = _shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = _shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
}
extension UIViewController {
        func showToast(message: String) {
            let toastContainer = UIView(frame: CGRect())
            toastContainer.backgroundColor = UIColor(named: "OrangeBtnBackgroundColor")?.withAlphaComponent(0.7)
            toastContainer.alpha = 0.0
            toastContainer.layer.cornerRadius = 20;
            toastContainer.clipsToBounds  =  true

            let toastLabel = UILabel(frame: CGRect())
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.font.withSize(12.0)
            toastLabel.text = message
            toastLabel.clipsToBounds  =  true
            toastLabel.numberOfLines = 0

            toastContainer.addSubview(toastLabel)
            self.view.addSubview(toastContainer)

            toastLabel.translatesAutoresizingMaskIntoConstraints = false
            toastContainer.translatesAutoresizingMaskIntoConstraints = false

            let centerX = NSLayoutConstraint(item: toastLabel, attribute: .centerX, relatedBy: .equal, toItem: toastContainer, attribute: .centerXWithinMargins, multiplier: 1, constant: 0)
            let lableBottom = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
            let lableTop = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
            toastContainer.addConstraints([centerX, lableBottom, lableTop])

            let containerCenterX = NSLayoutConstraint(item: toastContainer, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
            let containerTrailing = NSLayoutConstraint(item: toastContainer, attribute: .width, relatedBy: .equal, toItem: toastLabel, attribute: .width, multiplier: 1.1, constant: 0)
            let containertop = NSLayoutConstraint(item: toastContainer, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 50)
            self.view.addConstraints([containerCenterX,containerTrailing, containertop])

            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                toastContainer.alpha = 1.0
            }, completion: { _ in
                UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                    toastContainer.alpha = 0.0
                }, completion: {_ in
                    toastContainer.removeFromSuperview()
                })
            })
        }
    }
