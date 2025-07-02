//
//  MovieDetailsViewModel.swift
//  Movie app
//
//  Created by Mohamed Rizk on 02/07/2025.
//

import Foundation

@MainActor
final class MovieDetailsViewModel: ObservableObject {
    @Published private(set) var movie: Movie

    private let favoriteUsecase: FavoriteUsecaseProtocol

    init(movie: Movie, favoriteUsecase: FavoriteUsecaseProtocol) {
        self.movie = movie
        self.favoriteUsecase = favoriteUsecase
    }

    func toggleFavorite() {
        movie.isFavorite?.toggle() ?? (movie.isFavorite = true)
        do {
            try favoriteUsecase.updateFavoriteStatus(for: movie.id, isFavorite: movie.isFavorite ?? false)
        } catch {
            print("❌ Failed to update favorite: \(error)")
        }
    }
}
