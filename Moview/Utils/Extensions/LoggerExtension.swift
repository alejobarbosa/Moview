//
//  LoggerExtension.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//

import Foundation
import os.log

/// Extension for error handling
extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    ///Logs to call - receive services
    static let castError = Logger(subsystem: subsystem, category: Constants.LoggerCategories.cast)
    static let callServiceError = Logger(subsystem: subsystem, category: Constants.LoggerCategories.callService)
    static let buildingURLError = Logger(subsystem: subsystem, category: Constants.LoggerCategories.buildURL)
    static let dataError = Logger(subsystem: subsystem, category: Constants.LoggerCategories.dataError)
    
    ///Logs popular movies service
    static let getMoviesError = Logger(subsystem: subsystem, category: Constants.LoggerCategories.getPopularMovies)
    static let getMoviesSuccess = Logger(subsystem: subsystem, category: Constants.LoggerCategories.getPopularMovies)
    
    ///Logs movie detail service
    static let getMovieDetailError = Logger(subsystem: subsystem, category: Constants.LoggerCategories.getMovieDetail)
    static let getMovieDetailSuccess = Logger(subsystem: subsystem, category: Constants.LoggerCategories.getMovieDetail)
    
    ///Logs movie videos service
    static let getMovieVideosError = Logger(subsystem: subsystem, category: Constants.LoggerCategories.getMovieVideos)
    static let getMovieVideosSuccess = Logger(subsystem: subsystem, category: Constants.LoggerCategories.getMovieVideos)
    
    ///Logs to core data
    static let fetchDataCDError = Logger(subsystem: subsystem, category: Constants.LoggerCategories.fetchDataCD)
    static let fetchDataCDSuccess = Logger(subsystem: subsystem, category: Constants.LoggerCategories.fetchDataCD)
    static let saveDataCDError = Logger(subsystem: subsystem, category: Constants.LoggerCategories.saveDataCD)
    static let saveDataCDSuccess = Logger(subsystem: subsystem, category: Constants.LoggerCategories.saveDataCD)
    static let removeDataCDError = Logger(subsystem: subsystem, category: Constants.LoggerCategories.removeDataCD)
    static let removeDataCDSuccess = Logger(subsystem: subsystem, category: Constants.LoggerCategories.removeDataCD)
    
    
}
