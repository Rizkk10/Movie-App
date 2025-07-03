//
//  HomeUsecase.swift
//  Movie app
//
//  Created by Mohamed Rizk on 01/07/2025.
//

import Foundation

protocol HomeUsecaseProtocol {
    func fetchMovies() async throws -> [Movie]
}

final class HomeUsecase: HomeUsecaseProtocol {
    private let repo: HomeRepoInterface

    init(repo: HomeRepoInterface) {
        self.repo = repo
    }

    func fetchMovies() async throws -> [Movie] {
        try await repo.fetchMovies()
    }
}


