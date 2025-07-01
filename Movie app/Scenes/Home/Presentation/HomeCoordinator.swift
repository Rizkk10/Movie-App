//
//  HomeCoordinator.swift
//  Movie app
//
//  Created by Mohamed Rizk on 01/07/2025.
//

import Foundation
import UIKit

final class HomeCoordinator {
    
    @MainActor
    func start() -> UIViewController {
        let context = PersistenceController.shared.container.viewContext
        let coreDataStore = MovieCoreDataStore(context: context)
        let repo = HomeRepo(coreDataStore: coreDataStore)
        let usecase = HomeUsecase(repo: repo)
        let viewModel = HomeViewModel(usecase: usecase)
        let vc = HomeVC(viewModel: viewModel)
        
        return vc
    }
}
