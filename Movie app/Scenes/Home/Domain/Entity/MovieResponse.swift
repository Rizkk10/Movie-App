//
//  MovieResponse.swift
//  Movie app
//
//  Created by Mohamed Rizk on 01/07/2025.
//


struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Double
    let releaseDate: String
    let posterPath: String?
    let originalLanguage: String
    var isFavorite: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
    }
}

extension Movie {
    init(from entity: MovieEntity) {
        self.id = Int(entity.id)
        self.title = entity.title ?? ""
        self.overview = entity.overview ?? ""
        self.voteAverage = entity.voteAverage
        self.releaseDate = entity.releaseDate ?? ""
        self.posterPath = entity.posterPath
        self.originalLanguage = entity.originalLanguage ?? ""
        self.isFavorite = entity.isFavorite
    }
}

