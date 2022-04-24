//
//  Constants.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//

import Foundation

struct Constants {
    
    //MARK: Error View
    struct ErrorView {
        static let errorTitle = "¡Ups!"
        static let errorMessage = "An unexpected error occurred. Please try again later."
        static let noConectionMessage = "It looks like you have no internet connection."
    }
    
    //MARK: Generic
    static let acceptTitle = "Accept"
    
    //MARK: Images
    struct Images {
        static let icFavBlack = "ic_fav_black"
        static let icFavRed = "ic_fav_red"
        static let icFavWhite = "ic_fav_white"
        static let icHomeWhite = "ic_home_white"
        static let icInfoWhite = "ic_info_white"
    }
    
    //MARK: Logs Categories
    struct LoggerCategories {
        
        ///Categories to call - receive services
        static let cast = "cast"
        static let callService = "callService"
        static let buildURL = "buildURL"
        static let dataError = "dataError"
        
        ///Categorie to popular moviesservice
        static let getPopularMovies = "getPopularMovies"
        
    }
    
    //MARK: Titles
    struct Titles {
        static let homeVC = "Movies"
        static let favoritesVC = "Favorites"
        static let infoVC = "Info"
    }
    
}
