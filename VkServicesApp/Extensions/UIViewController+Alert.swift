//
//  UIViewController+Alert.swift
//  VkServicesApp
//
//  Created by Захар Литвинчук on 28.03.2024.
//

import UIKit

extension UIViewController {
    func showDecodingErrorAlert(for error: NetworkError, retryHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        alert.addAction(UIAlertAction(title: "Повторить", style: .default, handler: { _ in
            retryHandler()
        }))
        self.present(alert, animated: true)
    }
}
