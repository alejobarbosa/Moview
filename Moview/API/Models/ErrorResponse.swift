//
//  ErrorResponse.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//

import Foundation

// MARK: - ErrorResponses
enum ErrorResponses: Error {
    case invalidURL
    case emptyResponse
    case serviceFailure(Int)
    case invalidResponse(Error, String?)
    case unknownError(Error?)
    case noInternet(String)
}
