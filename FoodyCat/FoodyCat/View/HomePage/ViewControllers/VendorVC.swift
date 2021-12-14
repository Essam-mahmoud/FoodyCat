//
//  VendorVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 13/12/2021.
//

import UIKit
import Cosmos

class VendorVC: UIViewController {

    //MARK:- Outlets

    @IBOutlet weak var vendorImage: UIImageView!
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var vendorSpecialityLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var celebrityImage: UIImageView!
    @IBOutlet weak var celebrityNameLabel: UILabel!
    @IBOutlet weak var celibritySubtitleLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mealsCollectionView: UICollectionView!
    @IBOutlet weak var tabsCollectionView: UICollectionView!
    
    //MARK:- Properity

    var vendorImageURL = ""
    var celebrityImageURL = ""
    var celebrityName = ""
    var vendorNameLable = ""
    var vendorSpeciality = ""
    var vendorRating = 0
    var tabsArray = ["tab1","tab2","tab3","tab4","tab2","tab3","tab4","tab2","tab3","tab4"]
    fileprivate let mealCellName = "MealsCell"
    fileprivate let tabCellName = "TabsCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.layer.cornerRadius = 15
        if #available(iOS 11.0, *) {
            mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
        }
    }

    func setupUI() {
        vendorImage.loadImageFromUrl(imgUrl: vendorImageURL, defString: "")
        celebrityImage.loadImageFromUrl(imgUrl: celebrityImageURL, defString: "")
        celebrityNameLabel.text = celebrityName
        vendorNameLabel.text = vendorNameLable
        ratingView.rating = Double(vendorRating)
        ratingView.isUserInteractionEnabled = false
        registerCells()
    }

    func registerCells() {
        mealsCollectionView.delegate = self
        mealsCollectionView.dataSource = self
        mealsCollectionView.register(UINib(nibName: mealCellName, bundle: nil), forCellWithReuseIdentifier: mealCellName)

        tabsCollectionView.delegate = self
        tabsCollectionView.dataSource = self
        tabsCollectionView.register(UINib(nibName: tabCellName, bundle: nil), forCellWithReuseIdentifier: tabCellName)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabsCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
    }

    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension VendorVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 2000 {
            return 10
        } else {
            return tabsArray.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 2000 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mealCellName, for: indexPath) as? MealsCell else {return UICollectionViewCell()}
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tabCellName, for: indexPath) as? TabsCell else {return UICollectionViewCell()}
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 2000 {
            return CGSize(width: 182, height: 300)
        } else {
            let item = tabsArray[indexPath.row]
            let itemSize = item.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)
            ])
            return CGSize(width: collectionView.frame.width / 4, height: 40)
        }
    }
}

