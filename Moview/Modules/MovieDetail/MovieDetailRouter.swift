//
//  MovieDetailRouter.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import UIKit

protocol IMovieDetailRouter: AnyObject {
    func openLink(_ link: String)
}

class MovieDetailRouter: IMovieDetailRouter {	
	weak var view: MovieDetailViewController?
	
	init(view: MovieDetailViewController?) {
		self.view = view
	}
    
    func openLink(_ link: String) {
        guard let url = URL(string: link) else { return }
        UIApplication.shared.open(url)
    }
}
