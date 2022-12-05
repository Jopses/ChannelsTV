//
//  ChannelsResponse.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 03.12.2022.
//

import UIKit

struct ChannelsResponse: Decodable {
    let id: Int
    let name: String
    let image: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id
        case name = "name_ru"
        case image
        case current
        case url
    }
    
    enum CurrentCodingKeys: String, CodingKey {
        case title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
        
        let currentContainer = try container.nestedContainer(keyedBy: CurrentCodingKeys.self, forKey: .current)
        self.title = try currentContainer.decode(String.self, forKey: .title)
        
        self.url = try container.decode(String.self, forKey: .url)
    }
}
