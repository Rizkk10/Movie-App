//
//  HomeCoordinator.swift
//  Movie app
//
//  Created by Mohamed Rizk on 01/07/2025.
//

import Foundation
import UIKit

final class HomeCoordinator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    @MainActor
    func start() -> UIViewController {
        let context = PersistenceController.shared.container.viewContext
        let coreDataStore = MovieCoreDataStore(context: context)
        let repo = HomeRepo(coreDataStore: coreDataStore)
        
        let homeUsecase = HomeUsecase(repo: repo)
        let favoriteUsecase = FavoriteUsecase(repo: repo)
        
        let viewModel = HomeViewModel(homeUsecase: homeUsecase, favoriteUsecase: favoriteUsecase)
        let vc = HomeVC(viewModel: viewModel)

        vc.onMovieSelected = { [weak self] movie in
            self?.showMovieDetails(movie: movie, favoriteUsecase: favoriteUsecase)
        }

        return vc
    }

    @MainActor
    private func showMovieDetails(movie: Movie, favoriteUsecase: FavoriteUsecaseProtocol) {
        let detailsCoordinator = MovieDetailsCoordinator(navigationController: navigationController, favoriteUsecase: favoriteUsecase)
        detailsCoordinator.start(movie: movie)
    }

}
