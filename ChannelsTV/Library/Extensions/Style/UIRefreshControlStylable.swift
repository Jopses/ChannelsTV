//
//  UIRefreshControlStylable.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 04.12.2022.
//

import UIKit

extension StyleWrapper where Element == UIRefreshControl {
    static var primary: StyleWrapper {
        return .wrap { control, theme in
            control.tintColor = theme.colorPalette.onPrimary
        }
    }
}
