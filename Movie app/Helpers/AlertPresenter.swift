//
//  Alert Presenter.swift
//  Movie app
//
//  Created by Mohamed Rizk on 02/07/2025.
//

import UIKit

extension UIViewController {
    func showAlert(title: String = "Error", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
