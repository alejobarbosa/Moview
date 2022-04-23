//
//  HomeInteractor.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IHomeInteractor: class {
	var parameters: [String: Any]? { get set }
}

class HomeInteractor: IHomeInteractor {
    var presenter: IHomePresenter?
    var manager: IHomeManager?
    var parameters: [String: Any]?

    init(presenter: IHomePresenter, manager: IHomeManager) {
    	self.presenter = presenter
    	self.manager = manager
    }
}
