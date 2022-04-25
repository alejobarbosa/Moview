//
//  FavoritesInteractor.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import UIKit
import os.log

protocol IFavoritesInteractor: AnyObject {
	var movies: [MovieCD]! { get set }
    func fetchFavorites()
    func removeFavorite(id: Int)
}

class FavoritesInteractor: IFavoritesInteractor {
    
    var presenter: IFavoritesPresenter?
    var manager: IFavoritesManager?
    var movies: [MovieCD]! = []

    init(presenter: IFavoritesPresenter, manager: IFavoritesManager) {
    	self.presenter = presenter
    	self.manager = manager
        self.fetchFavorites()
    }
    
    //MARK: Fetch Favorites Movies
    func fetchFavorites(){
        self.manager?.fetchFavorites(handler: { [weak self] (response) in
            switch response {
            case .success(let moviesCD):
                self?.movies = moviesCD
                break
            default:
                break
            }
        })
    }
    
    //MARK: Remove Favorite Movie
    func removeFavorite(id: Int){
        if let movieToRemove = self.movies.filter({$0.id == id}).first {
            self.manager?.removeFavorite(movieCD: movieToRemove,
                                         handler: { [weak self] (success) in
                if success {
                    if let index = self?.movies.firstIndex(of: movieToRemove){
                        self?.movies.remove(at: index)
                        DispatchQueue.main.async {
                            self?.presenter?.reloadTableView()
                        }
                    }
                }
            })
        }
    }
    
}
