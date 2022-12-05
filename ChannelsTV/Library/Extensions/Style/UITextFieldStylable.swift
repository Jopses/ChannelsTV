//
//  UITextFieldStylable.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 04.12.2022.
//

import UIKit

extension StyleWrapper where Element == UITextField {
    static var search: StyleWrapper {
        return .wrap { textField, theme in
            textField.leftViewMode = .always
            let imageView = UIImageView()
            imageView.image = #imageLiteral(resourceName: "search.pdf")
            imageView.contentMode = .center
            imageView.frame = CGRect(x: Grid.sm.offset / 2, y: Grid.sm.offset / 2,
                                     width: Grid.sm.offset, height: Grid.sm.offset)
            let leftView = UIView(frame: CGRect(x: 0, y: 0,
                                                 width: 48,
                                                 height: 48)
            )

            leftView.addSubview(imageView)
            textField.leftView = leftView
            textField.textAlignment = .left
            textField.textColor = theme.colorPalette.onPrimary
            textField.backgroundColor = theme.colorPalette.surface
            textField.layer.cornerRadius = Grid.s.offset
            textField.font = theme.typography.subtitle2
            textField.attributedPlaceholder = NSAttributedString(
                string: Localized.writeNameChannel,
                attributes: [
                    .foregroundColor: theme.colorPalette.onSecondary,
                    .font: theme.typography.subtitle2
                ]
            )
            textField.clearButtonMode = .whileEditing
        }
    }
}
