//
//  ErrorHandler.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 03.12.2022.
//

import Foundation

class ErrorHandler {
    weak var messagesView: UserMessagesView?

    func handle(error: Error) {
        Logger.debugLog("Error: \(error)")
        let message = error.localizedDescription
        messagesView?.showErrorAlert(withMessage: message)
    }

    func handleMessage(message: String) {
        messagesView?.showErrorAlert(withMessage: message)
    }
}
