//
//  FavoriteRepo.swift
//  Movie app
//
//  Created by Mohamed Rizk on 03/07/2025.
//

import Foundation

final class FavoriteRepo: FavoriteRepoInterface {
    private let coreDataStore: MovieCoreDataStore

    init(coreDataStore: MovieCoreDataStore) {
        self.coreDataStore = coreDataStore
    }

    func updateFavoriteStatus(for id: Int, isFavorite: Bool) throws {
        try coreDataStore.updateFavoriteStatus(for: id, isFavorite: isFavorite)
    }
}
