//
//  FavoriteUsecaseProtocol.swift
//  Movie app
//
//  Created by Mohamed Rizk on 03/07/2025.
//

import Foundation

protocol FavoriteUsecaseProtocol {
    func updateFavoriteStatus(for id: Int, isFavorite: Bool) throws
}


final class FavoriteUsecase: FavoriteUsecaseProtocol {
    private let repo: FavoriteRepoInterface

    init(repo: FavoriteRepoInterface) {
        self.repo = repo
    }

    func updateFavoriteStatus(for id: Int, isFavorite: Bool) throws {
        try repo.updateFavoriteStatus(for: id, isFavorite: isFavorite)
    }
}
