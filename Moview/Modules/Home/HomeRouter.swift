//
//  HomeRouter.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import UIKit

protocol IHomeRouter: AnyObject {
    func navigateToDetail(movie: Movie)
}

class HomeRouter: IHomeRouter {	
	weak var view: HomeViewController?
	
	init(view: HomeViewController?) {
		self.view = view
	}
    
    func navigateToDetail(movie: Movie){
        let vc = MovieDetailConfiguration.setup(movie: movie)
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
}
