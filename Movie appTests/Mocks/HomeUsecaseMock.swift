//
//  HomeUsecaseMock.swift
//  Movie appTests
//
//  Created by Mohamed Rizk on 02/07/2025.
//

import Foundation
@testable import Movie_app

final class HomeUsecaseMock: HomeUsecaseProtocol {
    var mockMovies: [Movie] = []

    func fetchMovies() async throws -> [Movie] {
        return mockMovies
    }
}
