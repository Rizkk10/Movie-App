//
//  HomeRepoInterface.swift
//  Movie app
//
//  Created by Mohamed Rizk on 01/07/2025.
//

import Foundation

protocol HomeRepoInterface {
    func fetchMovies() async throws -> [Movie]
    func updateFavoriteStatus(for id: Int, isFavorite: Bool) throws
}
