//
//  MovieDetailsCoordinator.swift
//  Movie app
//
//  Created by Mohamed Rizk on 02/07/2025.
//

import Foundation
import UIKit

final class MovieDetailsCoordinator {

    private let navigationController: UINavigationController
    private let usecase: HomeUsecaseProtocol

    init(navigationController: UINavigationController, usecase: HomeUsecaseProtocol) {
        self.navigationController = navigationController
        self.usecase = usecase
    }

    @MainActor
    func start(movie: Movie) {
        let viewModel = MovieDetailsViewModel(movie: movie, usecase: usecase)
        let vc = MovieDetailsVC(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}
