//
//  OnboardingVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 02/01/2022.
//

import UIKit
import FSPagerView

class OnboardingVC: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var pageView: FSPagerView! {
        didSet {

            self.pageView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            let transform = CGAffineTransform(scaleX: 0.6, y: 0.75)
            self.pageView.itemSize = self.pageView.frame.size.applying(transform)
            self.pageView.decelerationDistance = 2
            self.pageView.automaticSlidingInterval = .init(3)
            self.pageView.transformer = FSPagerViewTransformer(type: .linear)
        }
    }
    @IBOutlet weak var pagerControl: FSPageControl! {
        didSet {
            self.pagerControl.numberOfPages = 3
            self.pagerControl.contentHorizontalAlignment = .right
            self.pagerControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.pagerControl.backgroundColor = .clear
            self.pagerControl.setFillColor(#colorLiteral(red: 0.968627451, green: 0.5960784314, blue: 0.1411764706, alpha: 1), for: .selected)
            self.pagerControl.setFillColor(#colorLiteral(red: 0.968627451, green: 0.5960784314, blue: 0.1411764706, alpha: 0.2), for: .normal)
            self.pagerControl.contentHorizontalAlignment = .center


        }
    }
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var imagesArray = ["first", "second", "third"]
    var mainTitleArray = ["Your Favorite Celebrities".localized(),
                          "Celebrities Favorite Restaurants".localized(),
                          "Fast delivery to your place".localized()]
    var descriptionArray = ["Discover the foods from over 3250 restaurants.".localized(),
                            "Celebrities Favorite Restaurants, See what celebrities suggestions.".localized(),
                            "Fast delivery to your home, office and wherever you are.".localized()]
    override func viewDidLoad() {
        super.viewDidLoad()
        pageView.delegate = self
        pageView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.layer.cornerRadius = 20
        if #available(iOS 11.0, *) {
            mainView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
        }
    }

    @IBAction func skipButtonDidPress(_ sender: UIButton) {
        SharedData.SharedInstans.setIsFinishOnboarding(true)
        let locationVc = GetUserLocationVC.instantiate(fromAppStoryboard: .Home)
        locationVc.modalPresentationStyle = .fullScreen
        self.present(locationVc, animated: true, completion: nil)
    }
    
    @IBAction func letsStartButtonDidPress(_ sender: UIButton) {
        SharedData.SharedInstans.setIsFinishOnboarding(true)
        let locationVc = GetUserLocationVC.instantiate(fromAppStoryboard: .Home)
        locationVc.modalPresentationStyle = .fullScreen
        self.present(locationVc, animated: true, completion: nil)
    }
}


extension OnboardingVC: FSPagerViewDataSource,FSPagerViewDelegate{
    // MARK:- FSPagerView DataSource

    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 3
    }

    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: imagesArray[index])
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = ""
        cell.textLabel?.backgroundColor = .clear
        return cell
    }

    // MARK:- FSPagerView Delegate

    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }

    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pagerControl.currentPage = targetIndex
        mainTitleLabel.text = mainTitleArray[targetIndex]
        descriptionLabel.text = descriptionArray[targetIndex]
    }

    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pagerControl.currentPage = pagerView.currentIndex
        mainTitleLabel.text = mainTitleArray[pagerView.currentIndex]
        descriptionLabel.text = descriptionArray[pagerView.currentIndex]
    }

}
