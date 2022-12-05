//
//  Mutable.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 02.12.2022.
//

import Foundation
import UIKit
import Combine

protocol Mutable { }

extension Mutable {
    func mutate(mutation: (inout Self) -> ()) -> Self {
        var val = self
        mutation(&val)
        return val
    }
}

extension Observable where T: Mutable {
    func mutate(mutation: @escaping (inout T) -> ()) -> T {
        return value.mutate(mutation: mutation)
    }
}

func with<T>(_ object: T, _ initializer: (T)->Void) -> T {
    initializer(object)
    return object
}
