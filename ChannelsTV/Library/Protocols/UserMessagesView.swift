//
//  UserMessagesView.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 03.12.2022.
//

import UIKit

protocol UserMessagesView: AnyObject {
    func showAlert(withTitle title: String?, message: String?)
    func showErrorAlert(withMessage message: String?)
}

extension UserMessagesView where Self: UIViewController {
    func showAlert(withTitle title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Localized.ok, style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }

    func showErrorAlert(withMessage message: String?) {
        showAlert(withTitle: Localized.error, message: message)
    }
}

