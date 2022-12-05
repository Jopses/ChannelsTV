//
//  Localized.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 03.12.2022.
//

import Foundation

final class Localized: NSObject {
    fileprivate override init() {}
}

// MARK: - Base

extension Localized {
    static var error: String {
        return NSLocalizedString("Error", comment: "Base")
    }
    static var ok: String {
        return NSLocalizedString("Ok", comment: "Base")
    }
    static var cancel: String {
        return NSLocalizedString("Cancel", comment: "Base")
    }
    static var done: String {
        return NSLocalizedString("Done", comment: "Base")
    }
}

// MARK: - Errors

extension Localized {
    static var urlNotValid: String {
        return NSLocalizedString("URL address is not valid", comment: "Network Errors")
    }
    static var failedToParseResponse: String {
        return NSLocalizedString("Failed to parse response", comment: "Network Errors")
    }
    static var unknownError: String {
        return NSLocalizedString("Unknown error", comment: "Network Errors")
    }
    static var notfound: String {
        return NSLocalizedString("Not found", comment: "Errors")
    }
}

// MARK: - App

extension Localized {
    static var writeNameChannel: String {
        return NSLocalizedString("Write the name of the TV channel", comment: "App")
    }
    static var all: String {
        return NSLocalizedString("All", comment: "App")
    }
    static var favorites: String {
        return NSLocalizedString("Favorites", comment: "App")
    }
    static var setting1080p: String {
        return NSLocalizedString("1080p", comment: "App")
    }
    static var setting720p: String {
        return NSLocalizedString("720p", comment: "App")
    }
    static var setting480p: String {
        return NSLocalizedString("480p", comment: "App")
    }
    static var setting360p: String {
        return NSLocalizedString("360p", comment: "App")
    }
    static var settingAuto: String {
        return NSLocalizedString("AUTO", comment: "App")
    }
}
