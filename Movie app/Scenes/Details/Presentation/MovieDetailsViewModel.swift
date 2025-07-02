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

    private let usecase: HomeUsecaseProtocol

    init(movie: Movie, usecase: HomeUsecaseProtocol) {
        self.movie = movie
        self.usecase = usecase
    }

    func toggleFavorite() {
        movie.isFavorite?.toggle() ?? (movie.isFavorite = true)
        do {
            try usecase.updateFavoriteStatus(for: movie.id, isFavorite: movie.isFavorite ?? false)
        } catch {
            print("❌ Failed to update favorite: \(error)")
        }
    }
}
