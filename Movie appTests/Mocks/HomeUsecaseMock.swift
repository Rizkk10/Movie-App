//
//  HomeUsecaseMock.swift
//  Movie appTests
//
//  Created by Mohamed Rizk on 02/07/2025.
//

import Foundation
@testable import Movie_app

final class HomeUsecaseMock: HomeUsecaseProtocol {
    var mockMovies: [Movie] = []
    var updatedFavorites: [(Int, Bool)] = []

    func fetchMovies() async throws -> [Movie] {
        return mockMovies
    }

    func updateFavoriteStatus(for id: Int, isFavorite: Bool) throws {
        updatedFavorites.append((id, isFavorite))
    }
}

