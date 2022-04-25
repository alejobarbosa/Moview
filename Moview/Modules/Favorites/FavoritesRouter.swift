//
//  FavoritesRouter.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import UIKit

protocol IFavoritesRouter: AnyObject {
    func navigateToDetail(movieCD: MovieCD)
}

class FavoritesRouter: IFavoritesRouter {	
	weak var view: FavoritesViewController?
	
	init(view: FavoritesViewController?) {
		self.view = view
	}
    
    func navigateToDetail(movieCD: MovieCD){
        let vc = MovieDetailConfiguration.setup(movie: nil, movieCD: movieCD)
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
}
