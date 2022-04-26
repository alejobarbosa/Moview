//
//  VideosResponse.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//

import Foundation

// MARK: - VideosResponse
struct VideosResponse: Codable {
    let id: Int?
    let results: [Video]?
}
