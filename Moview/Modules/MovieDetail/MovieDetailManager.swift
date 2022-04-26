//
//  MovieDetailManager.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import Foundation

protocol IMovieDetailManager: IBaseManager {
    func getMovieDetail(id: String,
                        handler: @escaping (Result<MovieDetail, ErrorResponses>) -> Void)
    func getVideos(id: String,
                   handler: @escaping (Result<VideosResponse, ErrorResponses>) -> Void)
}

class MovieDetailManager: BaseManager, IMovieDetailManager {
    
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
    
}
