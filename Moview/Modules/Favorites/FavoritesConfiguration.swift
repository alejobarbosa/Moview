//
//  FavoritesConfiguration.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation
import UIKit

class FavoritesConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = FavoritesViewController()
        let router = FavoritesRouter(view: controller)
        let presenter = FavoritesPresenter(view: controller)
        let manager = FavoritesManager()
        let interactor = FavoritesInteractor(presenter: presenter, manager: manager)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
