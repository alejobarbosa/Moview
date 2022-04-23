//
//  HomeConfiguration.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation
import UIKit

class HomeConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = HomeViewController()
        let router = HomeRouter(view: controller)
        let presenter = HomePresenter(view: controller)
        let manager = HomeManager()
        let interactor = HomeInteractor(presenter: presenter, manager: manager)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
