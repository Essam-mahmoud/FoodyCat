//
//  openImageVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 05/03/2022.
//

import UIKit

class openImageVC: UIViewController {

    @IBOutlet weak var fullImageView: UIImageView!
    var imageURL = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        fullImageView.loadImageFromUrl(imgUrl: imageURL, defString: "itemPlaceHolder")
        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
