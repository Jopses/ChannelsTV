//
//  String+calcSize.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 05.12.2022.
//

import UIKit

extension String {
    public func calcHeight(maxSize: CGSize, font: UIFont, lineHeight: CGFloat = 1) -> CGFloat {
        return calcSize(maxSize: maxSize, font: font, lineHeight: lineHeight).height
    }
    
    public func calcWidth(maxSize: CGSize, font: UIFont) -> CGFloat {
        return calcSize(maxSize: maxSize, font: font).width
    }
    
    public func calcSize(maxSize: CGSize, font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize), lineHeight: CGFloat = 1) -> CGSize {
        return NSString(string: self).boundingRect(
            with: maxSize,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.paragraphStyle: with(NSMutableParagraphStyle()) { $0.lineHeightMultiple = lineHeight }
            ],
            context: nil).size
    }
}
