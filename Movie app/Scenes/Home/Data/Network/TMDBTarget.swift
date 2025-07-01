//
//  TMDBTarget.swift
//  Movie app
//
//  Created by Mohamed Rizk on 01/07/2025.
//

import Moya
import Foundation

enum TMDBTarget {
    case bestMovies2025
}

extension TMDBTarget: TargetType {
    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3")!
    }

    var path: String {
        switch self {
        case .bestMovies2025:
            return "/discover/movie"
        }
    }

    var method: Moya.Method {
        .get
    }

    var task: Task {
        switch self {
        case .bestMovies2025:
            return .requestParameters(
                parameters: [
                    "primary_release_year": 2025,
                    "sort_by": "vote_average.desc",
                    "vote_count.gte": 50
                ],
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers: [String: String]? {
        [
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MzE4OTFhYjhhNDYwYjExOTc4OTIyOTFmNWZiYTMzYSIsIm5iZiI6MTc1MTM5MzM0MC4wNjgsInN1YiI6IjY4NjQyNDNjMmUzYWUwMTIzNzhjMjQyYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IrHLWZvRs9SghgyOH6tPfeiJdS3Uh4paO64o24CnMko",
            "Accept": "application/json"
        ]
    }

    var sampleData: Data {
        Data()
    }
}

