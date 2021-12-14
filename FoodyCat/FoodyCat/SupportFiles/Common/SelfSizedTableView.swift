	//
//  SelfSizedTableView.swift
//  Enara
//
//  Created by Mohamed on 3/9/20.
//  Copyright © 2020 Gyro media. All rights reserved.
//


    import UIKit

    final class ContentSizedTableView: UITableView {
        override var contentSize:CGSize {
            didSet {
                invalidateIntrinsicContentSize()
            }
        }

        override var intrinsicContentSize: CGSize {
            layoutIfNeeded()
            return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
        }
    }
