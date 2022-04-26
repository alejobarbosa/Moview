//
//  HomePresenter.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import UIKit

protocol IHomePresenter: AnyObject {
    func showError(message: String)
    func showData()
}

class HomePresenter: IHomePresenter {	
	weak var view: IHomeViewController?
	
	init(view: IHomeViewController?) {
		self.view = view
	}
    
    func showError(message: String) {
        self.view?.showError(message: message)
    }
    
    func showData() {
        self.view?.showData()
    }
}
