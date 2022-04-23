//
//  FavoritesRouter.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IFavoritesRouter: class {
	// do someting...
}

class FavoritesRouter: IFavoritesRouter {	
	weak var view: FavoritesViewController?
	
	init(view: FavoritesViewController?) {
		self.view = view
	}
}
