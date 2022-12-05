//
//  UILabelStylable.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 04.12.2022.
//

import UIKit

extension StyleWrapper where Element == UILabel {
    static func line(_ number: Int) -> StyleWrapper {
        .wrap { label, theme in
            label.numberOfLines = number
        }
    }
}
