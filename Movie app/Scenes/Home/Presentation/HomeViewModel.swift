//
//  HomeViewModel.swift
//  Movie app
//
//  Created by Mohamed Rizk on 01/07/2025.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var movies: [Movie] = []

    private let usecase: HomeUsecaseProtocol

    init(usecase: HomeUsecaseProtocol) {
        self.usecase = usecase
    }

    func loadMovies() async {
        do {
            let movies = try await usecase.fetchMovies()
            self.movies = movies
        } catch {
            print("❌ Failed to load movies: \(error)")
        }
    }
    
    func toggleFavorite(for id: Int) {
        guard let index = movies.firstIndex(where: { $0.id == id }) else { return }

        movies[index].isFavorite?.toggle() ?? (movies[index].isFavorite = true)

        do {
            try usecase.updateFavoriteStatus(for: id, isFavorite: movies[index].isFavorite ?? false)
        } catch {
            print("❌ Failed to update favorite: \(error)")
        }
    }

}
