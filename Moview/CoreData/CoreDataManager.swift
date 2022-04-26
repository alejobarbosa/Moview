//
//  CoreDataManager.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 25/04/22.
//

import UIKit
import os.log

class CoreDataManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: Fetch Favorites Movies
    func fetchFavorites(handler: @escaping (Result<[MovieCD], Error>) -> Void){
        do {
            let favoritesMovies = try context.fetch(MovieCD.fetchRequest())
            Logger.fetchDataCDSuccess.info("Fetch movies from Core Data")
            handler(.success(favoritesMovies))
        } catch {
            Logger.fetchDataCDError.error("Error fetching movies from Core Data")
            handler(.failure(error))
        }
    }
    
    //MARK: Save Favorite Movie
    func saveFavorite(id: Int,
                      overview: String,
                      posterPath: String,
                      releaseDate: String,
                      title: String,
                      voteAverage: Double,
                      handler: @escaping (Result<MovieCD, Error>) -> Void){
        let movieCD = MovieCD(context: self.context)
        movieCD.id = Int32(id)
        movieCD.overview = overview
        movieCD.posterPath = posterPath
        movieCD.releaseDate = releaseDate
        movieCD.title = title
        movieCD.voteAverage = voteAverage
        do {
            try self.context.save()
            Logger.saveDataCDSuccess.info("Save movie in Core Data")
            handler(.success(movieCD))
        } catch {
            Logger.saveDataCDError.error("Error saving movie in Core Data")
            handler(.failure(error))
        }
    }
    
    //MARK: Remove Favorite Movie
    func removeFavorite(id: Int, handler: @escaping (Bool) -> Void){
        self.fetchFavorites { (response) in
            switch response {
            case .success(let moviesCD):
                guard let index = moviesCD.firstIndex(where: {$0.id == id}) else {
                    Logger.saveDataCDError.error("Error removing movie from Core Data. Movie doesn't exists")
                    handler(false)
                    return
                }
                self.context.delete(moviesCD[index])
                do {
                    try self.context.save()
                    Logger.removeDataCDSuccess.info("Remove movie from Core Data")
                    handler(true)
                } catch {
                    Logger.saveDataCDError.error("Error removing movie from Core Data")
                    handler(false)
                }
                break
            case .failure:
                Logger.saveDataCDError.error("Error removing movie from Core Data")
                handler(false)
                break
            }
        }
    }
    
}
