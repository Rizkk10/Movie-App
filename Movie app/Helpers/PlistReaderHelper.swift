//
//  PlistReaderHelper.swift
//  Movie app
//
//  Created by Mohamed Rizk on 02/07/2025.
//

import Foundation

enum AppConfig {
    static var tmdbBaseURL: URL {
        guard let urlString = Bundle.main.infoDictionary?["TMDBBaseURL"] as? String,
              let url = URL(string: urlString) else {
            fatalError("❌ TMDBBaseURL missing or invalid in Info.plist")
        }
        return url
    }

    static var tmdbAccessToken: String {
        guard let token = Bundle.main.infoDictionary?["TMDBAccessToken"] as? String else {
            fatalError("❌ TMDBAccessToken missing in Info.plist")
        }
        return token
    }
}
