//
//  LoadingIndicator.swift
//  Movie app
//
//  Created by Mohamed Rizk on 02/07/2025.
//

import UIKit

final class LoadingIndicator {
    static let shared = LoadingIndicator()
    private var spinner: UIActivityIndicatorView?

    private init() {}

    func show(in view: UIView) {
        DispatchQueue.main.async {
            guard self.spinner == nil else { return }
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.center = view.center
            spinner.hidesWhenStopped = true
            spinner.startAnimating()
            view.addSubview(spinner)
            self.spinner = spinner
        }
    }

    func hide() {
        DispatchQueue.main.async {
            self.spinner?.stopAnimating()
            self.spinner?.removeFromSuperview()
            self.spinner = nil
        }
    }
}

