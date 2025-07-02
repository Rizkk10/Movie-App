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
    private let favoriteUsecase: FavoriteUsecaseProtocol

    init(navigationController: UINavigationController, favoriteUsecase: FavoriteUsecaseProtocol) {
        self.navigationController = navigationController
        self.favoriteUsecase = favoriteUsecase
    }

    @MainActor
    func start(movie: Movie) {
        let viewModel = MovieDetailsViewModel(movie: movie, favoriteUsecase: favoriteUsecase)
        let vc = MovieDetailsVC(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}
