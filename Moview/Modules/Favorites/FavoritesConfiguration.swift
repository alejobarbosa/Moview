//
//  FavoritesConfiguration.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import Foundation
import UIKit

class FavoritesConfiguration {
    static func setup() -> UIViewController {
        let controller = FavoritesViewController()
        let router = FavoritesRouter(view: controller)
        let presenter = FavoritesPresenter(view: controller)
        let coreDataManager = CoreDataManager()
        let comunicationManager = ComunicationManager()
        let manager = FavoritesManager(comunicationManager: comunicationManager, coreDataManager: coreDataManager)
        let interactor = FavoritesInteractor(presenter: presenter, manager: manager)
        
        controller.interactor = interactor
        controller.router = router
        return controller
    }
}
