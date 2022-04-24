//
//  ServicesConstants.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//

import Foundation

struct ServicesConstants {
    
    ///Keys to use in the calls of serices
    struct ServiceKeys {
        static let queryKey = "q"
        static let categoryKey = "category"
        static let pageKey = "page"
        static let apiKey = "api_key"
        static let itemId = "{MOVIE_ID}"
    }
    
    ///Builder to get the each url
    struct URL {
        var domain: String = ""
        
        init() {
            self.domain = getMainDomain()
        }
        
        func getMainDomain() -> String {
            return "https://api.themoviedb.org/3/movie"
        }
        
        func getImageBaseURL() -> String {
            return "https://image.tmdb.org/t/p/w500"
        }
        
        func getYoutubeBaseURL() -> String {
            return "https://www.youtube.com/watch?v="
        }
        
        func getIMDbBaseURL() -> String {
            return "https://www.imdb.com/title/"
        }
        
        func getPopularMovies() -> String {
            return domain + "/popular"
        }
        
        func getMovieDetailPath() -> String {
            return domain + "/{MOVIE_ID}"
        }
        
        func getVideosPath() -> String {
            return domain + "/{MOVIE_ID}/videos"
        }
        
    }
    
    ///Common values used in services request
    enum ServiceCommonHeaders {
        static let httpGet = "GET"
        static let applicationJSON = "application/json"
        static let contentTypeKey = "Content-Type"
        static let acceptKey = "Accept"
    }
    
    static let APIKey = "c13cbe41bdca17d060ce49012f8ac3a1"
    
    
}
