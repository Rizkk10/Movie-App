//
//  FavoriteUsecaseMock.swift
//  Movie appTests
//
//  Created by Mohamed Rizk on 02/07/2025.
//

import Foundation
@testable import Movie_app

final class FavoriteUsecaseMock: FavoriteUsecaseProtocol {
    var updatedFavorites: [(Int, Bool)] = []

    func updateFavoriteStatus(for id: Int, isFavorite: Bool) throws {
        updatedFavorites.append((id, isFavorite))
    }
}

