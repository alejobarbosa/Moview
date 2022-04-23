//
//  FavoritesViewController.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IFavoritesViewController: class {
	var router: IFavoritesRouter? { get set }
}

class FavoritesViewController: UIViewController {
	var interactor: IFavoritesInteractor?
	var router: IFavoritesRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension FavoritesViewController: IFavoritesViewController {
	// do someting...
}

extension FavoritesViewController {
	// do someting...
}

extension FavoritesViewController {
	// do someting...
}
