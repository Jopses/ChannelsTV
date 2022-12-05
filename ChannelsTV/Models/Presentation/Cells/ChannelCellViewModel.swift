//
//  ChannelCellViewModel.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 04.12.2022.
//

import UIKit

class ChannelCellViewModel: PreparableViewModel, Hashable {
    let cellId: String = ChannelCell.className
    let props: ChannelCell.Props

    init(props: ChannelCell.Props) {
        self.props = props
    }

    static func == (lhs: ChannelCellViewModel, rhs: ChannelCellViewModel) -> Bool {
        lhs.props == rhs.props
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(props.channel?.id)
    }
}
