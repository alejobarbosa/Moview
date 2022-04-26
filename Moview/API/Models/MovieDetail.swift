//
//  MovieDetailResponse.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//

import Foundation

// MARK: - MovieDetail
struct MovieDetail: Codable {
    let adult: Bool?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int?
    let tagline: String?
    let title: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case genres
        case homepage
        case id
        case imdbID = "imdb_id"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case tagline
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
