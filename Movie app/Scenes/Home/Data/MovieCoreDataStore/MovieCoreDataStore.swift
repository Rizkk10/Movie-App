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
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        let existingEntities = try context.fetch(fetchRequest)
        var favoriteMap: [Int32: Bool] = [:]
        existingEntities.forEach { favoriteMap[$0.id] = $0.isFavorite }

        for entity in existingEntities {
            context.delete(entity)
        }

        for movie in movies {
            let entity = MovieEntity(context: context)
            entity.id = Int32(movie.id)
            entity.title = movie.title
            entity.overview = movie.overview
            entity.voteAverage = movie.voteAverage
            entity.releaseDate = movie.releaseDate
            entity.posterPath = movie.posterPath
            entity.originalLanguage = movie.originalLanguage
            entity.isFavorite = favoriteMap[Int32(movie.id)] ?? movie.isFavorite ?? false
        }

        try context.save()

        for movie in movies {
            downloadAndSavePoster(for: movie)
        }
    }

    
    
    
    
    func fetchMovies() throws -> [Movie] {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        let results = try context.fetch(request)
        
        print("⚠️ CoreData: \(results.count) movies fetched")

        let ids = results.map { $0.id }
        let duplicates = Dictionary(grouping: ids, by: { $0 }).filter { $1.count > 1 }
        if !duplicates.isEmpty {
            print("‼️ Duplicate IDs in CoreData: \(duplicates)")
        }

        return results.map { Movie(from: $0) }
    }

    
    func updateFavoriteStatus(for movieID: Int, isFavorite: Bool) throws {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", movieID)
        request.fetchLimit = 1
        
        if let movieEntity = try context.fetch(request).first {
            movieEntity.isFavorite = isFavorite
            try context.save()
        }
    }
    
    func downloadAndSavePoster(for movie: Movie) {
        guard let posterPath = movie.posterPath,
              let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self,
                  let data = data,
                  error == nil else { return }
            
            self.context.perform {
                let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
                request.predicate = NSPredicate(format: "id == %d", movie.id)
                request.fetchLimit = 1
                
                if let entity = try? self.context.fetch(request).first {
                    entity.posterImage = data
                    try? self.context.save()
                }
            }
        }.resume()
    }
    
    
}
