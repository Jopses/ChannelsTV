//
//  NCSTarget.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 03.12.2022.
//

import Foundation

protocol NCSTarget {
    var baseURL: String { get }
    var path: String { get }
    var method: NCSMethod { get }
}
