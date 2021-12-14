//
//  CollectionViewHieght.swift
//  ZoyThree
//
//  Created by Essam on 2/26/20.
//  Copyright © 2020 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class SelfSizedCollectionView: UICollectionView {
//    override func reloadData() {
//        super.reloadData()
//        self.invalidateIntrinsicContentSize()
//    }

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        let s = self.collectionViewLayout.collectionViewContentSize
        return CGSize(width: max(s.width, 1), height: contentSize.height)
    }

}
