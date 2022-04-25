//
//  MovieDetailManager.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import Foundation

protocol IMovieDetailManager: AnyObject {
    func getMovieDetail(id: String,
                        handler: @escaping (Result<MovieDetail, ErrorResponses>) -> Void)
    func getVideos(id: String,
                   handler: @escaping (Result<VideosResponse, ErrorResponses>) -> Void)
    func fetchFavorites(handler: @escaping (Result<[MovieCD], Error>) -> Void)
    func saveFavorite(id: Int,
                      overview: String,
                      posterPath: String,
                      releaseDate: String,
                      title: String,
                      voteAverage: Double,
                      handler: @escaping (Result<MovieCD, Error>) -> Void)
    func removeFavorite(movieCD: MovieCD,
                        handler: @escaping (Bool) -> Void)
}

class MovieDetailManager: IMovieDetailManager {
    private let comunicationManager = ComunicationManager()
    private let coreDataManager = CoreDataManager()
    
    func getMovieDetail(id: String,
                        handler: @escaping (Result<MovieDetail, ErrorResponses>) -> Void) {
        comunicationManager.getMovieDetail(id: id,
                                           handler: handler)
    }
    
    func getVideos(id: String,
                   handler: @escaping (Result<VideosResponse, ErrorResponses>) -> Void){
        comunicationManager.getVideos(id: id,
                                      handler: handler)
    }
    
    func fetchFavorites(handler: @escaping (Result<[MovieCD], Error>) -> Void){
        coreDataManager.fetchFavorites(handler: handler)
    }
    
    func saveFavorite(id: Int,
                      overview: String,
                      posterPath: String,
                      releaseDate: String,
                      title: String,
                      voteAverage: Double,
                      handler: @escaping (Result<MovieCD, Error>) -> Void){
        coreDataManager.saveFavorite(id: id,
                                     overview: overview,
                                     posterPath: posterPath,
                                     releaseDate: releaseDate,
                                     title: title,
                                     voteAverage: voteAverage,
                                     handler: handler)
    }
    
    func removeFavorite(movieCD: MovieCD, handler: @escaping (Bool) -> Void){
        coreDataManager.removeFavorite(movieCD: movieCD, handler: handler)
    }
    
}
