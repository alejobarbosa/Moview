//
//  HomeInteractor.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import UIKit
import os.log

protocol IHomeInteractor {
    func getPopularMovies()
    func getMoreMovies()
    func saveFavorite(movie: Movie, index: Int)
    func removeFavorite(id: Int)
    var isNewCall: Bool { get set }
    var movies: [Movie] { get set }
}

class HomeInteractor: IHomeInteractor {
    var presenter: IHomePresenter?
    var manager: IHomeManager?
    var movies: [Movie] = []
    var totalPages: Int = 1
    var page: Int = 1
    var isNewCall: Bool = true
    var isLoading: Bool = false
    var favoritesMovies: [MovieCD] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    init(presenter: IHomePresenter, manager: IHomeManager) {
    	self.presenter = presenter
    	self.manager = manager
    }
    
    //MARK: Get popular movies service
    func getPopularMovies(){
        self.manager?.getPopularMovies(page: self.page,
                                       handler: {[weak self] (response) in
            switch response {
            case .success(let moviesResponse):
                DispatchQueue.main.async {
                    self?.totalPages = moviesResponse.totalPages ?? 1
                    if (self?.isNewCall ?? true) {
                        self?.movies = moviesResponse.results ?? [Movie]()
                        self?.fetchFavorites()
                    } else {
                        self?.movies.append(contentsOf: moviesResponse.results ?? [Movie]())
                        self?.updateMovies()
                    }
                    self?.isLoading = false
                    Logger.getMoviesSuccess.info("Showing popular movies successfully")
                }
                break
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.showError(message: self?.getErrorMessage(error: error) ?? "")
                    self?.isLoading = false
                    Logger.getMoviesError.error("Error showing popular movies")
                }

                break
            }
        })
    }
    
    //MARK: Fetch Favorites Movies
    private func fetchFavorites(){
        do {
            self.favoritesMovies = try context.fetch(MovieCD.fetchRequest())
            self.updateMovies()
            Logger.fetchDataCDSuccess.info("Fetch movies from Core Data")
        } catch {
            DispatchQueue.main.async {
                self.presenter?.showData()
            }
            Logger.fetchDataCDError.error("Error fetching movies from Core Data")
        }
    }
    
    //MARK: Update Movies
    private func updateMovies(){
        for (index, i) in self.movies.enumerated() {
            if !(self.favoritesMovies.filter({$0.id == i.id ?? -1}).isEmpty){
                self.movies[index].isFav = true
            }
        }
        DispatchQueue.main.async {
            self.presenter?.showData()
        }
    }
    
    //MARK: Save Favorite Movie
    func saveFavorite(movie: Movie, index: Int){
        let movieCD = MovieCD(context: self.context)
        movieCD.id = Int32(movie.id ?? 0)
        movieCD.overview = movie.overview
        movieCD.posterPath = movie.posterPath
        movieCD.releaseDate = movie.releaseDate
        movieCD.title = movie.title
        movieCD.voteAverage = movie.voteAverage ?? 0.0
        do {
            try self.context.save()
            self.favoritesMovies.append(movieCD)
            self.movies[index].isFav = true
            Logger.saveDataCDSuccess.info("Save movie in Core Data")
        } catch {
            Logger.saveDataCDError.error("Error saving movie in Core Data")
        }
    }
    
    //MARK: Remove Favorite Movie
    func removeFavorite(id: Int){
        if let movieToRemove = self.favoritesMovies.filter({$0.id == id}).first {
            self.context.delete(movieToRemove)
            do {
                try self.context.save()
                if let index = self.favoritesMovies.firstIndex(of: movieToRemove){
                    self.favoritesMovies.remove(at: index)
                    for (index, i) in self.movies.enumerated() where i.id == id{
                        self.movies[index].isFav = false
                    }
                }
                Logger.removeDataCDSuccess.info("Remove movie from Core Data")
            } catch {
                Logger.saveDataCDError.error("Error removing movie from Core Data")
            }
        }
    }
    
    //MARK: Service Get More Products
    func getMoreMovies() {
        if !isLoading {
            self.page = self.page + 1
            if self.page <= self.totalPages {
                self.isNewCall = false
                self.getPopularMovies()
            }
        }
    }
    
    //MARK: Error Message
    func getErrorMessage(error: ErrorResponses) -> String {
        if !error.localizedDescription.isEmpty {
            return error.localizedDescription
        }
        return Constants.ErrorView.errorMessage
    }
}
