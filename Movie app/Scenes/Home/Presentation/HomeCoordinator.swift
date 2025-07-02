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
        let usecase = HomeUsecase(repo: repo)
        let viewModel = HomeViewModel(usecase: usecase)
        let vc = HomeVC(viewModel: viewModel)

        vc.onMovieSelected = { [weak self] movie in
            guard let self = self else { return }
            showMovieDetails(movie: movie, usecase: usecase)
        }

        return vc
    }

    @MainActor
    private func showMovieDetails(movie: Movie, usecase: HomeUsecaseProtocol) {
        let detailsCoordinator = MovieDetailsCoordinator(navigationController: navigationController, usecase: usecase)
        detailsCoordinator.start(movie: movie)
    }
}
