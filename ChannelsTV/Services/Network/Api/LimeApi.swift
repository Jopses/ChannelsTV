//
//  LimeApi.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 03.12.2022.
//

import UIKit

enum LimeApi {
    case getPlaylist
}

// MARK: - Moya setup

extension LimeApi: NCSTarget {
    var baseURL: String {
        AppDefaults.limehdUrl
    }

    var path: String {
        switch self {
        case .getPlaylist:
            return "/playlist/channels.json"
        }
    }

    var method: NCSMethod {
        switch self {
        case .getPlaylist:
            return .get
        }
    }

}
