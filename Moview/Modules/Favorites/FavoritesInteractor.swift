//
//  FavoritesInteractor.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

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
    
    //MARK: Fetch Favorites Movies
    func fetchFavorites(){
        do {
            self.movies = try context.fetch(MovieCD.fetchRequest())
        } catch {
            
        }
    }
    
}
