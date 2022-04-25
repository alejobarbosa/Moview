//
//  MovieDetailInteractor.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit
import os.log

protocol IMovieDetailInteractor: AnyObject {
	var movie: Movie! { get set }
    var movieDetail: MovieDetail? { get set }
    var trailer: Video? { get set }
    func getMovieDetail()
    func saveFavorite()
    func removeFavorite()
}

class MovieDetailInteractor: IMovieDetailInteractor {
    var presenter: IMovieDetailPresenter?
    var manager: IMovieDetailManager?
    var movie: Movie!
    var movieDetail: MovieDetail?
    var trailer: Video?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favoritesMovies: [MovieCD] = []

    init(presenter: IMovieDetailPresenter, manager: IMovieDetailManager) {
    	self.presenter = presenter
    	self.manager = manager
        self.fetchFavorites()
    }
    
    //MARK: Get Movie Detail
    func getMovieDetail() {
        self.manager?.getMovieDetail(id: String(self.movie.id ?? 0),
                                     handler: {[weak self] (response) in
            switch response {
            case .success(let movieDetail):
                DispatchQueue.main.async {
                    self?.movieDetail = movieDetail
                    self?.presenter?.showData()
                    self?.getVideos()
                    Logger.searchProductSuccess.info("Showing movie detail successfully")
                }
                break
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.showError(message: self?.getErrorMessage(error: error) ?? "")
                    Logger.searchProductError.error("Error showing movie detail")
                }

                break
            }
        })
    }
    
    //MARK: Get Movie Videos
    private func getVideos(){
        self.manager?.getVideos(id: String(self.movie.id ?? 0),
                                handler: {[weak self] (response) in
            switch response {
            case .success(let videosResponse):
                DispatchQueue.main.async {
                    let video = videosResponse.results?.filter({$0.site == MovieDetailModel.Texts.youtube})
                    self?.trailer = video?.filter({$0.type == MovieDetailModel.Texts.trailer}).first
                    self?.presenter?.showTrailer()
                    Logger.searchProductSuccess.info("Showing videos successfully")
                }
                break
                
            case .failure:
                DispatchQueue.main.async {
                    self?.presenter?.hideProgress()
                    Logger.searchProductError.error("Error showing videos")
                }

                break
            }
        })
    }
    
    //MARK: Fetch Favorites Movies
    private func fetchFavorites(){
        do {
            self.favoritesMovies = try context.fetch(MovieCD.fetchRequest())
        } catch {
        }
    }
    
    //MARK: Save Favorite Movie
    func saveFavorite(){
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
            self.movie.isFav = true
        } catch {
//            Logger.
        }
    }
    
    //MARK: Remove Favorite Movie
    func removeFavorite(){
        if let movieToRemove = self.favoritesMovies.filter({$0.id == movie.id ?? 0}).first {
            self.context.delete(movieToRemove)
            do {
                try self.context.save()
                if let index = self.favoritesMovies.firstIndex(of: movieToRemove){
                    self.favoritesMovies.remove(at: index)
                    self.movie.isFav = false
                }
            } catch {
                
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
