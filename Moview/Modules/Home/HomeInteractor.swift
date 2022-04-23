//
//  HomeInteractor.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit
import os.log

protocol IHomeInteractor {
    func getPopularMovies()
    func getMoreMovies()
    func saveFavorite(movie: Movie)
    var isNewCall: Bool { get set }
    var movies: [Movie] { get set }
}

class HomeInteractor: IHomeInteractor {
    var presenter: IHomePresenter?
    var manager: IHomeManager?
    var movies: [Movie] = []
    var totalPages: Int = 1
    var page: Int = 1
    var isNewCall: Bool = true
    var isLoading: Bool = false

    init(presenter: IHomePresenter, manager: IHomeManager) {
    	self.presenter = presenter
    	self.manager = manager
    }
    
    func getPopularMovies(){
        self.manager?.getPopularMovies(page: self.page,
                                       handler: {[weak self] (response) in
            switch response {
            case .success(let moviesResponse):
                DispatchQueue.main.async {
                    self?.totalPages = moviesResponse.totalPages
                    if (self?.isNewCall ?? true) {
                        self?.movies = moviesResponse.results
                    } else {
                        self?.movies.append(contentsOf: moviesResponse.results)
                    }
                    self?.presenter?.showData()
                    self?.isLoading = false
                    Logger.searchProductSuccess.info("Showing popular movies successfully")
                }
                break
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.showError(message: self?.getErrorMessage(error: error) ?? "")
                    self?.isLoading = false
                    Logger.searchProductError.error("Error showing popular movies")
                }

                break
            }
        })
    }
    
    func saveFavorite(movie: Movie){
        
    }
    
    //MARK: Service Get More Products
    func getMoreMovies() {
        if !isLoading {
            self.page = self.page + 1
            if self.page <= self.totalPages {
                self.isNewCall = false
                self.getPopularMovies()
            }
        }
    }
    
    //MARK: Error Message
    func getErrorMessage(error: ErrorResponses) -> String {
        if !error.localizedDescription.isEmpty {
            return error.localizedDescription
        }
        return Constants.ErrorView.errorMessage
    }
}
