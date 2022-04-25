//
//  MovieDetailInteractor.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import UIKit
import os.log

protocol IMovieDetailInteractor: AnyObject {
	var movie: Movie! { get set }
    var movieDetail: MovieDetail? { get set }
    var movieCD: MovieCD? { get set }
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
    var favoritesMovies: [MovieCD] = []
    var movieCD: MovieCD?

    init(presenter: IMovieDetailPresenter, manager: IMovieDetailManager) {
    	self.presenter = presenter
    	self.manager = manager
        self.fetchFavorites()
    }
    
    //MARK: Get Movie Detail
    func getMovieDetail() {
        let id = self.movieCD != nil ? Int(movieCD?.id ?? 0) : self.movie.id
        self.manager?.getMovieDetail(id: String(id ?? 0),
                                     handler: {[weak self] (response) in
            switch response {
            case .success(let movieDetail):
                DispatchQueue.main.async {
                    self?.movieDetail = movieDetail
                    self?.presenter?.showData()
                    self?.getVideos()
                    Logger.getMovieDetailSuccess.info("Showing movie detail successfully")
                }
                break
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.showError(message: self?.getErrorMessage(error: error) ?? "")
                    Logger.getMovieDetailError.error("Error showing movie detail")
                }

                break
            }
        })
    }
    
    //MARK: Get Movie Videos
    private func getVideos(){
        let id = self.movieCD != nil ? Int(movieCD?.id ?? 0) : self.movie.id
        self.manager?.getVideos(id: String(id ?? 0),
                                handler: {[weak self] (response) in
            switch response {
            case .success(let videosResponse):
                DispatchQueue.main.async {
                    let video = videosResponse.results?.filter({$0.site == MovieDetailModel.Texts.youtube})
                    self?.trailer = video?.filter({$0.type == MovieDetailModel.Texts.trailer}).first
                    self?.presenter?.showTrailer()
                    Logger.getMovieVideosSuccess.info("Showing videos successfully")
                }
                break
                
            case .failure:
                DispatchQueue.main.async {
                    self?.presenter?.hideProgress()
                    Logger.getMovieVideosError.error("Error showing videos")
                }

                break
            }
        })
    }
    
    //MARK: Fetch Favorites Movies
    private func fetchFavorites(){
        self.manager?.fetchFavorites(handler: { [weak self] (response) in
            switch response {
            case .success(let moviesCD):
                self?.favoritesMovies = moviesCD
                break
            default:
                break
            }
        })
    }
    
    //MARK: Save Favorite Movie
    func saveFavorite(){
        self.manager?.saveFavorite(id: movieDetail?.id ?? 0,
                                   overview: movieDetail?.overview ?? "",
                                   posterPath: movieDetail?.posterPath ?? "",
                                   releaseDate: movieDetail?.releaseDate ?? "",
                                   title: movieDetail?.title ?? "",
                                   voteAverage: movieDetail?.voteAverage ?? 0.0,
                                   handler: { [weak self] (response) in
            switch response {
            case .success(let movieCD):
                self?.favoritesMovies.append(movieCD)
                if self?.movie != nil {
                    self?.movie.isFav = true
                }
                break
            default:
                break
            }
        })
    }
    
    //MARK: Remove Favorite Movie
    func removeFavorite(){
        if let movieToRemove = self.favoritesMovies.filter({$0.id == movieDetail?.id ?? 0}).first {
            self.manager?.removeFavorite(movieCD: movieToRemove, handler: { [weak self] (success) in
                if success,
                   let index = self?.favoritesMovies.firstIndex(of: movieToRemove){
                    self?.favoritesMovies.remove(at: index)
                    if self?.movie != nil {
                        self?.movie.isFav = false
                    }
                }
            })
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
