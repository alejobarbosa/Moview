//
//  MovieDetailConfiguration.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation
import UIKit

class MovieDetailConfiguration {
    static func setup(movie: Movie?, movieCD: MovieCD? = nil) -> UIViewController {
        let controller = MovieDetailViewController()
        let router = MovieDetailRouter(view: controller)
        let presenter = MovieDetailPresenter(view: controller)
        let manager = MovieDetailManager()
        let interactor = MovieDetailInteractor(presenter: presenter, manager: manager)
        
        controller.interactor = interactor
        controller.router = router
        interactor.movie = movie
        interactor.movieCD = movieCD
        return controller
    }
}
