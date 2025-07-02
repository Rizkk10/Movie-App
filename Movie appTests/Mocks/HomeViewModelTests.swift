//
//  HomeViewModelTests.swift
//  Movie appTests
//
//  Created by Mohamed Rizk on 02/07/2025.
//

import XCTest
@testable import Movie_app

final class HomeViewModelTests: XCTestCase {

    @MainActor
    func test_loadMovies_populatesMoviesArray() async {
        // Arrange
        let usecase = HomeUsecaseMock()
        usecase.mockMovies = [
            Movie(id: 1, title: "Inception", overview: "Dream within a dream.", voteAverage: 8.8, releaseDate: "2010-07-16", posterPath: nil, originalLanguage: "en")
        ]
        let viewModel = HomeViewModel(usecase: usecase)

        // Act
        await viewModel.loadMovies()

        // Assert
        XCTAssertEqual(viewModel.movies.count, 1)
        XCTAssertEqual(viewModel.movies.first?.title, "Inception")
    }


    @MainActor
    func test_toggleFavorite_updatesFavoriteStatus() {
        // Arrange
        let usecase = HomeUsecaseMock()
        let movie = Movie(id: 42, title: "Matrix", overview: "", voteAverage: 9.0, releaseDate: "1999", posterPath: nil, originalLanguage: "en", isFavorite: false)
        let viewModel = HomeViewModel(usecase: usecase)
        viewModel.movies = [movie]

        // Act
        viewModel.toggleFavorite(for: 42)

        // Assert
        XCTAssertEqual(viewModel.movies.first?.isFavorite, true)
        XCTAssertEqual(usecase.updatedFavorites.first?.0, 42)
        XCTAssertEqual(usecase.updatedFavorites.first?.1, true)
    }
}

