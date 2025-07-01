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
}
