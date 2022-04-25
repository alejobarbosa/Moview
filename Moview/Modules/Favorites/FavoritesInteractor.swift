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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    init(presenter: IFavoritesPresenter, manager: IFavoritesManager) {
    	self.presenter = presenter
    	self.manager = manager
        self.fetchFavorites()
    }
    
    //MARK: Fetch Favorites Movies
    func fetchFavorites(){
        do {
            self.movies = try context.fetch(MovieCD.fetchRequest())
            Logger.fetchDataCDSuccess.info("Fetch movies from Core Data")
        } catch {
            Logger.fetchDataCDError.error("Error fetching movies from Core Data")
        }
    }
    
    //MARK: Remove Favorite Movie
    func removeFavorite(id: Int){
        if let movieToRemove = self.movies.filter({$0.id == id}).first {
            self.context.delete(movieToRemove)
            do {
                try self.context.save()
                if let index = self.movies.firstIndex(of: movieToRemove){
                    self.movies.remove(at: index)
                    self.presenter?.reloadTableView()
                }
            } catch {
                
            }
        }
    }
    
}
