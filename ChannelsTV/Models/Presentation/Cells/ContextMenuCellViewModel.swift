//
//  ContextMenuCellViewModel.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 05.12.2022.
//

import UIKit

class ContextMenuCellViewModel: PreparableViewModel {
    let cellId: String = ContextMenuCell.className
    let props: ContextMenuCell.Props

    init(props: ContextMenuCell.Props) {
        self.props = props
    }

    static func == (lhs: ContextMenuCellViewModel, rhs: ContextMenuCellViewModel) -> Bool {
        lhs.props == rhs.props
    }
}
