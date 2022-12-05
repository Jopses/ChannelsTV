//
//  UserDataService.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 04.12.2022.
//

import Foundation

final class UserDataService {
    
    enum Keys: String {
        case favoriteChannels
    }
    
    private let defult = UserDefaults.standard
    
    func setData<T: Codable>(_ data: T, key: Keys) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.set(encoded, forKey: key.rawValue)
        }
    }

    func getData<T: Codable>(key: Keys) -> T? {
        guard let list = UserDefaults.standard.object(forKey: key.rawValue) as? Data else {
            return nil
        }
        let decoder = JSONDecoder()
        if let loaded = try? decoder.decode(T.self, from: list) {
            return loaded
        }
        return nil
    }
}
