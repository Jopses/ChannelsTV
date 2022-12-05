//
//  TabsSegmentItem.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 05.12.2022.
//

import UIKit

enum TabsSegmentItem: Int, Equatable, CaseIterable {
    case all = 0
    case favorite = 1
    
    var title: String {
        switch self {
        case .all:
            return Localized.all
        case .favorite:
            return Localized.favorites
        }
    }
    var textColor: UIColor {
        DefaultColorPalette.onPrimary.withAlphaComponent(0.5)
    }
    var selectedTextColor: UIColor {
        DefaultColorPalette.onPrimary
    }
    var underlineColor: UIColor {
        DefaultColorPalette.secondaryVariant
    }
}
