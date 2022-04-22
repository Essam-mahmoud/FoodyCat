//
//  ShowPaymentURLVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 22/04/2022.
//

import UIKit
import WebKit

class ShowPaymentURLVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var link = ""
    let sucessPart  = "success=true"
    let faliurePart = "success=false"
    let errorPart   = "payment/error"
    var address: AddressData?
    var orderNumber = 0
    var paymentName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let trimmedLink = link.trimmingCharacters(in: .whitespaces)
        let url = URL(string: trimmedLink)!
        let urlRequest = URLRequest(url: url)
        webView.navigationDelegate = self
        webView.load(urlRequest)
        // Do any additional setup after loading the view.
    }

    func scanUrl(_ url: URL) {

        let urlString = url.absoluteString.lowercased()
        if urlString.contains(sucessPart) {
            onSucess()
            print("sucess url = \(urlString)")
        } else if urlString.contains(faliurePart) {
            showFaliurePopup()
            print("faliure url = \(urlString)")
        } else if urlString.contains(errorPart){
             showFaliurePopup()
            print("Error url = \(urlString)")
        } else {
            print("not interested url = \(urlString)")
        }
    }

    private func showFaliurePopup() {
        let alert = UIAlertController(title: "⚠️ Payment Failed".localized(), message: "We are unable to process your payment.".localized(), preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Try Again".localized(), style: .default, handler: { [weak self] action in
             guard let self = self else {return}
             self.dismiss(animated: true, completion: nil)
         }))
         self.present(alert, animated: true)
     }

    private func onSucess() {
        let thankVc = ThanksPageVC.instantiate(fromAppStoryboard: .CheckOut)
        thankVc.address = self.address
        thankVc.orderNumber = self.orderNumber
        thankVc.payment = self.paymentName
        thankVc.modalPresentationStyle = .fullScreen
        self.present(thankVc, animated: true, completion: nil)
    }
}

extension ShowPaymentURLVC: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        if navigationAction.request.url != nil{
            if let redirectUrl = navigationAction.request.url {
                scanUrl(redirectUrl)
            }
        }
        decisionHandler(.allow)
    }
}
