//
//  NetworkErrors.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 03.12.2022.
//

import Foundation

enum NetworkErrors: Error, LocalizedError {
    case urlNotValid
    case failedToParseResponse
    case unknownError

    var errorDescription: String? {
        return localizedDescription
    }

    var localizedDescription: String {
        switch self {
        case .urlNotValid:
            return Localized.urlNotValid
        case .failedToParseResponse:
            return Localized.failedToParseResponse
        case .unknownError:
            return Localized.unknownError
        }
    }
}
