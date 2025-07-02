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

protocol FavoriteUsecaseProtocol {
    func updateFavoriteStatus(for id: Int, isFavorite: Bool) throws
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

final class FavoriteUsecase: FavoriteUsecaseProtocol {
    private let repo: HomeRepoInterface

    init(repo: HomeRepoInterface) {
        self.repo = repo
    }

    func updateFavoriteStatus(for id: Int, isFavorite: Bool) throws {
        try repo.updateFavoriteStatus(for: id, isFavorite: isFavorite)
    }
}
