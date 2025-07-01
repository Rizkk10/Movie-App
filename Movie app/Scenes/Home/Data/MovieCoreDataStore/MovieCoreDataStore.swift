//
//  MovieCoreDataStore.swift
//  Movie app
//
//  Created by Mohamed Rizk on 01/07/2025.
//

import Foundation
import CoreData

final class MovieCoreDataStore {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func save(movies: [Movie]) throws {
        let semaphore = DispatchSemaphore(value: 0)
        var capturedError: Error?

        context.perform {
            for movie in movies {
                let entity = MovieEntity(context: self.context)
                entity.id = Int32(movie.id)
                entity.title = movie.title
                entity.overview = movie.overview
                entity.voteAverage = movie.voteAverage
                entity.releaseDate = movie.releaseDate
                entity.posterPath = movie.posterPath
                entity.originalLanguage = movie.originalLanguage
                entity.isFavorite = movie.isFavorite ?? false
            }

            do {
                try self.context.save()
            } catch {
                capturedError = error
            }

            semaphore.signal()
        }

        semaphore.wait()

        if let error = capturedError {
            throw error
        }
    }


    func fetchMovies() throws -> [Movie] {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        let results = try context.fetch(request)

        return results.map { Movie(from: $0) }
    }
    
}
