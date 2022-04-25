//
//  FavoritesPresenter.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IFavoritesPresenter: AnyObject {
	func reloadTableView()
}

class FavoritesPresenter: IFavoritesPresenter {	
	weak var view: IFavoritesViewController?
	
	init(view: IFavoritesViewController?) {
		self.view = view
	}
    
    func reloadTableView() {
        self.view?.reloadTableView()
    }
}
