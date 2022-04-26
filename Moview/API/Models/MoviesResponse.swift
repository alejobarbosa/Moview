//
//  MoviesResponse.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//

import Foundation

// MARK: - MoviesResponse
struct MoviesResponse: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
