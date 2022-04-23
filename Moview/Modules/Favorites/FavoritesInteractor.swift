//
//  FavoritesInteractor.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IFavoritesInteractor: class {
	var parameters: [String: Any]? { get set }
}

class FavoritesInteractor: IFavoritesInteractor {
    var presenter: IFavoritesPresenter?
    var manager: IFavoritesManager?
    var parameters: [String: Any]?

    init(presenter: IFavoritesPresenter, manager: IFavoritesManager) {
    	self.presenter = presenter
    	self.manager = manager
    }
}
