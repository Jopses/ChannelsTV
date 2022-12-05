//
//  ChannelsListResponse.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 03.12.2022.
//

import UIKit

struct ChannelsListResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case channels
    }
    let channels: [ChannelsResponse]
}
