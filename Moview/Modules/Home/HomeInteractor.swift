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
            self.manager?.fetchFavorites(handler: { [weak self] (response) in
                switch response {
                case .success(let moviesCD):
                    self?.favoritesMovies = moviesCD
                    self?.updateMovies()
                    break
                case .failure:
                    DispatchQueue.main.async {
                        self?.presenter?.showData()
                    }
                    break
                }
            })
        }
    }
    
    //MARK: Update Movies
    func updateMovies(){
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
        self.manager?.saveFavorite(id: movie.id ?? 0,
                                   overview: movie.overview ?? "",
                                   posterPath: movie.posterPath ?? "",
                                   releaseDate: movie.releaseDate ?? "",
                                   title: movie.title ?? "",
                                   voteAverage: movie.voteAverage ?? 0.0,
                                   handler: { [weak self] (response) in
            switch response {
            case .success(let movieCD):
                self?.favoritesMovies.append(movieCD)
                self?.movies[index].isFav = true
                break
            default:
                break
            }
        })
    }
    
    //MARK: Remove Favorite Movie
    func removeFavorite(id: Int){
        self.manager?.removeFavorite(id: id, handler: { [weak self] (success) in
            if success,
               let indexFav = self?.favoritesMovies.firstIndex(where: {$0.id == id}),
               let indexMovie = self?.movies.firstIndex(where: {$0.id == id}) {
                self?.favoritesMovies.remove(at: indexFav)
                self?.movies[indexMovie].isFav = false
            }
        })
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
        var message = ""
        switch error {
        case .noInternet(let string):
            message = string
            break
        default:
            message = Constants.ErrorView.errorMessage
        }
        return message
    }
}
