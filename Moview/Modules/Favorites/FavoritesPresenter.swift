//
//  FavoritesPresenter.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IFavoritesPresenter: class {
	// do someting...
}

class FavoritesPresenter: IFavoritesPresenter {	
	weak var view: IFavoritesViewController?
	
	init(view: IFavoritesViewController?) {
		self.view = view
	}
}
