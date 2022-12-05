//
//  UIView+addSubviews.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 04.12.2022.
//

import UIKit

extension UIView {
    public func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
