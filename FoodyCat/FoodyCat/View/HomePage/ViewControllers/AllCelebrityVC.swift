//
//  AllCelebrityVC.swift
//  FoodyCat
//
//  Created by Essam Orabi on 15/12/2021.
//

import UIKit

class AllCelebrityVC: UIViewController {

    @IBOutlet weak var celebrityCollectionView: UICollectionView!

    fileprivate let celebritiesCell = "CelebritiesCell"
    var page = 1
    var counter = 2
    var homeVM = HomeVM()
    var celebrityArray = [CeleberitiesData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        celebrityCollectionView.delegate = self
        celebrityCollectionView.dataSource = self
        celebrityCollectionView.register(UINib(nibName: celebritiesCell, bundle: nil), forCellWithReuseIdentifier: celebritiesCell)
        loadCelebrities()
    }

    func loadCelebrities() {
        homeVM.getCeleberities(pageNumber: page) { (errMsg, errRes, status) in
            switch status {
            case .populated:
                self.celebrityArray.append(contentsOf: self.homeVM.celeberitiesModel?.data ?? [CeleberitiesData]())
                if UIDevice.current.userInterfaceIdiom == .pad {
                    if self.counter > 0{
                        self.counter -= 1
                        self.page += 1
                        self.loadCelebrities()
                    }
                }
                self.celebrityCollectionView.reloadData()
            case .error:
                AppCommon.sharedInstance.showBanner(title: self.homeVM.baseReponse?.message ?? "", subtitle: "", style: .danger)
            default:
                break
            }
        }
    }
    @IBAction func backButtonDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AllCelebrityVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return celebrityArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: celebritiesCell, for: indexPath) as? CelebritiesCell else {return UICollectionViewCell()}
        cell.setupCell(data: celebrityArray[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 103, height: 143)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
            let celebrity = celebrityArray[indexPath.row]
            let celebrityVC = CelebritiesVC.instantiate(fromAppStoryboard: .Home)
            celebrityVC.celebrityId = celebrity.id ?? 0
            celebrityVC.celebrityImageURL = celebrity.mediaFullPath ?? ""
            celebrityVC.celebrityName = celebrity.name ?? ""
            celebrityVC.modalPresentationStyle = .fullScreen
            present(celebrityVC, animated: true, completion: nil)
    }
}

extension AllCelebrityVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if celebrityCollectionView.contentOffset.y + celebrityCollectionView.frame.height >= celebrityCollectionView.contentSize.height {
            if page < homeVM.celeberitiesModel?.pageCount ?? 1 {
                page += 1
                loadCelebrities()
            }
        }
    }
}

