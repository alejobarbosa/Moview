//
//  FavoritesManager.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import Foundation

protocol IFavoritesManager: AnyObject {
    func fetchFavorites(handler: @escaping (Result<[MovieCD], Error>) -> Void)
    func removeFavorite(movieCD: MovieCD,
                        handler: @escaping (Bool) -> Void)
}

class FavoritesManager: IFavoritesManager {
    
    private let coreDataManager = CoreDataManager()
	
    func fetchFavorites(handler: @escaping (Result<[MovieCD], Error>) -> Void){
        coreDataManager.fetchFavorites(handler: handler)
    }
    
    func removeFavorite(movieCD: MovieCD, handler: @escaping (Bool) -> Void){
        coreDataManager.removeFavorite(movieCD: movieCD, handler: handler)
    }
    
}
