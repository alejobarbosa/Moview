//
//  FavoritesPresenter.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

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
