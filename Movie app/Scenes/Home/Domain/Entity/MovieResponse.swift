//
//  MovieResponse.swift
//  Movie app
//
//  Created by Mohamed Rizk on 01/07/2025.
//


struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let vote_average: Double
    let release_date: String
}
