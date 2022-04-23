//
//  HomePresenter.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IHomePresenter: class {
	// do someting...
}

class HomePresenter: IHomePresenter {	
	weak var view: IHomeViewController?
	
	init(view: IHomeViewController?) {
		self.view = view
	}
}
