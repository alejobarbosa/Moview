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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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
        do {
            self.favoritesMovies = try context.fetch(MovieCD.fetchRequest())
            Logger.fetchDataCDSuccess.info("Fetch movies from Core Data")
        } catch {
            Logger.fetchDataCDError.error("Error fetching movies from Core Data")
        }
    }
    
    //MARK: Save Favorite Movie
    func saveFavorite(){
        let movieCD = MovieCD(context: self.context)
        movieCD.id = Int32(movieDetail?.id ?? 0)
        movieCD.overview = movieDetail?.overview
        movieCD.posterPath = movieDetail?.posterPath
        movieCD.releaseDate = movieDetail?.releaseDate
        movieCD.title = movieDetail?.title
        movieCD.voteAverage = movieDetail?.voteAverage ?? 0.0
        do {
            try self.context.save()
            self.favoritesMovies.append(movieCD)
            if self.movie != nil {
                self.movie.isFav = true
            }
            Logger.saveDataCDSuccess.info("Save movie in Core Data")
        } catch {
            Logger.saveDataCDError.error("Error saving movie in Core Data")
        }
    }
    
    //MARK: Remove Favorite Movie
    func removeFavorite(){
        if let movieToRemove = self.favoritesMovies.filter({$0.id == movieDetail?.id ?? 0}).first {
            self.context.delete(movieToRemove)
            do {
                try self.context.save()
                if let index = self.favoritesMovies.firstIndex(of: movieToRemove){
                    self.favoritesMovies.remove(at: index)
                    if self.movie != nil {
                        self.movie.isFav = false
                    }
                }
                Logger.removeDataCDSuccess.info("Remove movie from Core Data")
            } catch {
                Logger.saveDataCDError.error("Error removing movie from Core Data")
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
