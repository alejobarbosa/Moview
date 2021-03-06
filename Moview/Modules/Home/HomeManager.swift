//
//  HomeManager.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import Foundation

protocol IHomeManager: IBaseManager {
    func getPopularMovies(page: Int,
                          handler: @escaping (Result<MoviesResponse, ErrorResponses>) -> Void)
}

class HomeManager: BaseManager, IHomeManager {
    
    func getPopularMovies(page: Int,
                          handler: @escaping (Result<MoviesResponse, ErrorResponses>) -> Void) {
        comunicationManager.getPopulatMovies(page: page,
                                             handler: handler)
    }
}
