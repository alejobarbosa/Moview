//
//  MovieDetailPresenter.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IMovieDetailPresenter: AnyObject {
    func showError(message: String)
    func showData()
    func showTrailer()
    func hideProgress()
}

class MovieDetailPresenter: IMovieDetailPresenter {	
	weak var view: IMovieDetailViewController?
	
	init(view: IMovieDetailViewController?) {
		self.view = view
	}
    
    func showError(message: String) {
        self.view?.showError(message: message)
    }
    
    func showData() {
        self.view?.showData()
    }
    
    func hideProgress() {
        self.view?.hideProgress()
    }
     
    func showTrailer(){
        self.view?.showTrailer()
    }
}
