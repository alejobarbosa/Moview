//
//  HomeManager.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

protocol IHomeManager {
    func getPopularMovies(page: Int,
                          handler: @escaping (Result<MoviesResponse, ErrorResponses>) -> Void)
}

class HomeManager: IHomeManager {
    private let comunicationManager = ComunicationManager()
    
    func getPopularMovies(page: Int,
                          handler: @escaping (Result<MoviesResponse, ErrorResponses>) -> Void) {
        comunicationManager.getPopulatMovies(page: page,
                                             handler: handler)
    }
}
