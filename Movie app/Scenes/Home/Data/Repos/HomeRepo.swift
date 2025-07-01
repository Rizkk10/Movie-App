//
//  HomeRepo.swift
//  Movie app
//
//  Created by Mohamed Rizk on 01/07/2025.
//

import Foundation
import Moya

final class HomeRepo: HomeRepoInterface {

    private let provider: MoyaProvider<TMDBTarget>
    private let coreDataStore: MovieCoreDataStore

    init(provider: MoyaProvider<TMDBTarget> = MoyaProvider<TMDBTarget>(), coreDataStore: MovieCoreDataStore) {
        self.provider = provider
        self.coreDataStore = coreDataStore
    }

    func fetchMovies() async throws -> [Movie] {
        let isConnected = ConnectivityManager.shared.isConnected
        
        if isConnected {
            do {
                let response = try await provider.request(TMDBTarget.bestMovies2025)
                let decoded = try JSONDecoder().decode(MovieResponse.self, from: response.data)
                try coreDataStore.save(movies: decoded.results)
                return decoded.results
            } catch {
                print("⚠️ API failed, fallback to CoreData: \(error)")
                return try coreDataStore.fetchMovies()
            }
        } else {
            print("📴 No internet, loading from CoreData")
            return try coreDataStore.fetchMovies()
        }
    }

    
}
