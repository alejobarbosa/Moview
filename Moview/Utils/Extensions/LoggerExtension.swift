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
    static let searchProductError = Logger(subsystem: subsystem, category: Constants.LoggerCategories.getPopularMovies)
    static let searchProductSuccess = Logger(subsystem: subsystem, category: Constants.LoggerCategories.getPopularMovies)
    
    ///Logs to core data
//    static let fetchDataError = Logger(subsystem: subsystem, category: <#T##String#>)
    
}
