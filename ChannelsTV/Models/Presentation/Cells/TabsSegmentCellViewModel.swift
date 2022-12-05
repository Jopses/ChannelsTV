//
//  TabsSegmentCellViewModel.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 05.12.2022.
//

import UIKit

class TabsSegmentCellViewModel: PreparableViewModel, Equatable {
    let cellId: String = TabsSegmentCell.className
    let props: TabsSegmentCell.Props

    init(props: TabsSegmentCell.Props) {
        self.props = props
    }

    static func == (lhs: TabsSegmentCellViewModel, rhs: TabsSegmentCellViewModel) -> Bool {
        lhs.props == rhs.props
    }
}
