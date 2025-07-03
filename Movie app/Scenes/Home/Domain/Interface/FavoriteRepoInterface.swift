//
//  FavoriteRepoInterface.swift
//  Movie app
//
//  Created by Mohamed Rizk on 03/07/2025.
//

import Foundation

protocol FavoriteRepoInterface {
    func updateFavoriteStatus(for id: Int, isFavorite: Bool) throws
}
