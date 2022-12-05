//
//  ChannelModel.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 04.12.2022.
//

import Foundation

struct ChannelModel: Hashable {
    let id: Int
    let name: String
    let image: String
    let currentProgramm: String
    let url: String
    var isFavorite: Bool
    
    static func == (lhs: ChannelModel, rhs: ChannelModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.image == rhs.image &&
        lhs.currentProgramm == rhs.currentProgramm &&
        lhs.url == rhs.url &&
        lhs.isFavorite == rhs.isFavorite
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
