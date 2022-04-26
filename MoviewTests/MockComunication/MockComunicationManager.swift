//
//  MockComunicationManager.swift
//  MoviewTests
//
//  Created by Luis Alejandro Barbosa Lee on 25/04/22.
//

import Foundation
@testable import Moview

class MockComunicationManager: ComunicationManager {
    
    var shouldReturnError = false
    var data = Data()
    
    override func getPopulatMovies(page: Int, handler: @escaping (Result<MoviesResponse, ErrorResponses>) -> Void) {
        if shouldReturnError {
            handler(.failure(.unknownError(nil)))
        } else {
            let serviceResponse: MoviesResponse
            //Parsing Data
            do {
                serviceResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
            } catch {
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.invalidResponse(error, json)))
                return
            }
            handler(.success(serviceResponse))
        }
    }
    
    override func getMovieDetail(id: String, handler: @escaping (Result<MovieDetail, ErrorResponses>) -> Void) {
        if shouldReturnError {
            handler(.failure(.unknownError(nil)))
        } else {
            let serviceResponse: MovieDetail
            //Parsing Data
            do {
                serviceResponse = try JSONDecoder().decode(MovieDetail.self, from: data)
            } catch {
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.invalidResponse(error, json)))
                return
            }
            handler(.success(serviceResponse))
        }
    }
    
    override func getVideos(id: String, handler: @escaping (Result<VideosResponse, ErrorResponses>) -> Void) {
        if shouldReturnError {
            handler(.failure(.unknownError(nil)))
        } else {
            let serviceResponse: VideosResponse
            //Parsing Data
            do {
                serviceResponse = try JSONDecoder().decode(VideosResponse.self, from: data)
            } catch {
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.invalidResponse(error, json)))
                return
            }
            handler(.success(serviceResponse))
        }
    }
    
    
}


