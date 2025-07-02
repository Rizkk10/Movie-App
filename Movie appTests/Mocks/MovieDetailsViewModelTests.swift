//
//  MovieDetailsViewModelTests.swift
//  Movie appTests
//
//  Created by Mohamed Rizk on 02/07/2025.
//

import XCTest
@testable import Movie_app

final class MovieDetailsViewModelTests: XCTestCase {

    @MainActor
    func test_toggleFavorite_flipsFavoriteStatus() {
        // Arrange
        let favoriteUsecase = FavoriteUsecaseMock()
        let movie = Movie(id: 10, title: "Interstellar", overview: "", voteAverage: 8.6, releaseDate: "2014", posterPath: nil, originalLanguage: "en", isFavorite: false)
        let viewModel = MovieDetailsViewModel(movie: movie, favoriteUsecase: favoriteUsecase)

        // Act
        viewModel.toggleFavorite()

        // Assert
        XCTAssertTrue(viewModel.movie.isFavorite ?? false)
        XCTAssertEqual(favoriteUsecase.updatedFavorites.first?.0, 10)
        XCTAssertEqual(favoriteUsecase.updatedFavorites.first?.1, true)
    }
}
