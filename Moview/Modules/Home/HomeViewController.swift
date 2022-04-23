//
//  HomeViewController.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IHomeViewController: class {
	var router: IHomeRouter? { get set }
}

class HomeViewController: UIViewController {
	var interactor: IHomeInteractor?
	var router: IHomeRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension HomeViewController: IHomeViewController {
	// do someting...
}

extension HomeViewController {
	// do someting...
}

extension HomeViewController {
	// do someting...
}
