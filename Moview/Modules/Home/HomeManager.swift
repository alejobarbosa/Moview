//
//  HomeManager.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import Foundation

protocol IHomeManager: AnyObject {
    func getPopularMovies(page: Int,
                          handler: @escaping (Result<MoviesResponse, ErrorResponses>) -> Void)
    func fetchFavorites(handler: @escaping (Result<[MovieCD], Error>) -> Void)
    func saveFavorite(id: Int,
                      overview: String,
                      posterPath: String,
                      releaseDate: String,
                      title: String,
                      voteAverage: Double,
                      handler: @escaping (Result<MovieCD, Error>) -> Void)
    func removeFavorite(movieCD: MovieCD, handler: @escaping (Bool) -> Void)
}

class HomeManager: IHomeManager {
    private let comunicationManager = ComunicationManager()
    private let coreDataManager = CoreDataManager()
    
    func getPopularMovies(page: Int,
                          handler: @escaping (Result<MoviesResponse, ErrorResponses>) -> Void) {
        comunicationManager.getPopulatMovies(page: page,
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
