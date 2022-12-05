//
//  UITableViewStylable.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 04.12.2022.
//

import UIKit

extension StyleWrapper where Element == UITableView {
    static var primary: StyleWrapper {
        return .wrap { table, _ in
            (table as UIView).apply(.backgroundColor)
            table.contentInset = UIEdgeInsets(top: 12.0, left: 0.0, bottom: 12.0, right: 0.0)
            table.separatorStyle = .none
            table.rowHeight = UITableView.automaticDimension
            table.showsVerticalScrollIndicator = false
            if #available(iOS 15, *) {
                table.sectionHeaderTopPadding = 0
            }
            table.tableFooterView = UIView()
        }
    }
    
    static var context: StyleWrapper {
        return .wrap { table, _ in
            (table as UIView).apply(.onPrimaryColor)
            table.separatorInset = UIEdgeInsets (top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            table.layer.cornerRadius = 12.0
            table.rowHeight = ContextMenuSize.itemHeight
            table.isScrollEnabled = false
            table.showsVerticalScrollIndicator = false
            if #available(iOS 15, *) {
                table.sectionHeaderTopPadding = 0
            }
            table.tableFooterView = UIView()
        }
    }
}
