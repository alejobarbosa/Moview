//
//  ComunicationManager.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//

import Foundation
import os.log

class ComunicationManager {
    
    let session = URLSession(configuration: .default)
    
    //MARK: - Get Popular Movies
    func getPopulatMovies(page: Int,
                          handler: @escaping (Result<MoviesResponse, ErrorResponses>) -> Void) {
        
        //Validation Internet
        if !NetworkManager().validateConnection() {
            handler(.failure(.noInternet(Constants.ErrorView.noConectionMessage)))
        }
        
        //Building URL
        let apiKey = URLQueryItem(name: ServicesConstants.ServiceKeys.apiKey,value: ServicesConstants.APIKey)
        let offset = URLQueryItem(name: ServicesConstants.ServiceKeys.pageKey, value: String(page))
        let path = ServicesConstants.URL().getPopularMovies()
        guard let url = URL(string: path) else {
            Logger.buildingURLError.error("Error creating the URL for popular movies service call")
            return handler(.failure(.invalidURL))
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            Logger.buildingURLError.error("Error creating the URL for popular movies service call")
            return handler(.failure(.invalidURL))
        }
        components.queryItems = [apiKey, offset]
        guard let composedUrl = components.url else {
            Logger.buildingURLError.error("Error creating the URL for popular movies service call")
            return handler(.failure(.invalidURL))
        }
        
        //Creating Request
        var request = URLRequest(url: composedUrl)
        request.httpMethod = ServicesConstants.ServiceCommonHeaders.httpGet
        request.setValue(ServicesConstants.ServiceCommonHeaders.applicationJSON,
                         forHTTPHeaderField: ServicesConstants.ServiceCommonHeaders.contentTypeKey)
        request.setValue(ServicesConstants.ServiceCommonHeaders.applicationJSON,
                         forHTTPHeaderField: ServicesConstants.ServiceCommonHeaders.acceptKey)
        
        //Executing Request
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                Logger.callServiceError.error("Get popular movies error: \(error.localizedDescription)")
                handler(.failure(.unknownError(error)))
                return
            }
            
            //Handling Response
            let httpResposne = response as! HTTPURLResponse
            guard case 200..<300 = httpResposne.statusCode else {
                Logger.callServiceError.error("Get popular movies error: \(httpResposne.statusCode)")
                handler(.failure(.serviceFailure(httpResposne.statusCode)))
                return
            }
            
            guard let data = data else {
                Logger.dataError.error("Get popular movies error: Missing Data")
                handler(.failure(.emptyResponse))
                return
            }
            
            let serviceResponse: MoviesResponse
            
            //Parsing Data
            do {
                serviceResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
            } catch {
                Logger.castError.error("Popular movies casting error: \(error.localizedDescription)")
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.invalidResponse(error, json)))
                return
            }

            handler(.success(serviceResponse))
        }
        task.resume()
    }
    
    
    //MARK: - Get Movie Detail
    func getMovieDetail(id: String,
                        handler: @escaping (Result<MovieDetail, ErrorResponses>) -> Void) {
        
        //Validation Internet
        if !NetworkManager().validateConnection() {
            handler(.failure(.noInternet(Constants.ErrorView.noConectionMessage)))
        }
        
        //Building URL
        let apiKey = URLQueryItem(name: ServicesConstants.ServiceKeys.apiKey,value: ServicesConstants.APIKey)
        let path = ServicesConstants.URL().getMovieDetailPath()
        let fullPath = path.replacingOccurrences(of: ServicesConstants.ServiceKeys.itemId, with: id)
        guard let url = URL(string: fullPath) else {
            Logger.buildingURLError.error("Error creating the URL for movie detail service call")
            return handler(.failure(.invalidURL))
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            Logger.buildingURLError.error("Error creating the URL for movie detail service call")
            return handler(.failure(.invalidURL))
        }
        components.queryItems = [apiKey]
        guard let composedUrl = components.url else {
            Logger.buildingURLError.error("Error creating the URL for movie detail service call")
            return handler(.failure(.invalidURL))
        }
        
        //Creating Request
        var request = URLRequest(url: composedUrl)
        request.httpMethod = ServicesConstants.ServiceCommonHeaders.httpGet
        request.setValue(ServicesConstants.ServiceCommonHeaders.applicationJSON,
                         forHTTPHeaderField: ServicesConstants.ServiceCommonHeaders.contentTypeKey)
        request.setValue(ServicesConstants.ServiceCommonHeaders.applicationJSON,
                         forHTTPHeaderField: ServicesConstants.ServiceCommonHeaders.acceptKey)
        
        //Executing Request
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                Logger.callServiceError.error("Get movie detail error: \(error.localizedDescription)")
                handler(.failure(.unknownError(error)))
                return
            }
            
            //Handling Response
            let httpResposne = response as! HTTPURLResponse
            guard case 200..<300 = httpResposne.statusCode else {
                Logger.callServiceError.error("Get movie detail error: \(httpResposne.statusCode)")
                handler(.failure(.serviceFailure(httpResposne.statusCode)))
                return
            }
            
            guard let data = data else {
                Logger.dataError.error("Get movie detail error: Missing Data")
                handler(.failure(.emptyResponse))
                return
            }
            
            let serviceResponse: MovieDetail
            
            //Parsing Data
            do {
                serviceResponse = try JSONDecoder().decode(MovieDetail.self, from: data)
            } catch {
                Logger.castError.error("Movie detail casting error: \(error.localizedDescription)")
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.invalidResponse(error, json)))
                return
            }

            handler(.success(serviceResponse))
        }
        task.resume()
    }
    
    //MARK: - Get Movie Detail
    func getVideos(id: String,
                   handler: @escaping (Result<VideosResponse, ErrorResponses>) -> Void) {
        
        //Validation Internet
        if !NetworkManager().validateConnection() {
            handler(.failure(.noInternet(Constants.ErrorView.noConectionMessage)))
        }
        
        //Building URL
        let apiKey = URLQueryItem(name: ServicesConstants.ServiceKeys.apiKey,value: ServicesConstants.APIKey)
        let path = ServicesConstants.URL().getVideosPath()
        let fullPath = path.replacingOccurrences(of: ServicesConstants.ServiceKeys.itemId, with: id)
        guard let url = URL(string: fullPath) else {
            Logger.buildingURLError.error("Error creating the URL for movie videos service call")
            return handler(.failure(.invalidURL))
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            Logger.buildingURLError.error("Error creating the URL for movie videos service call")
            return handler(.failure(.invalidURL))
        }
        components.queryItems = [apiKey]
        guard let composedUrl = components.url else {
            Logger.buildingURLError.error("Error creating the URL for movie videos service call")
            return handler(.failure(.invalidURL))
        }
        
        //Creating Request
        var request = URLRequest(url: composedUrl)
        request.httpMethod = ServicesConstants.ServiceCommonHeaders.httpGet
        request.setValue(ServicesConstants.ServiceCommonHeaders.applicationJSON,
                         forHTTPHeaderField: ServicesConstants.ServiceCommonHeaders.contentTypeKey)
        request.setValue(ServicesConstants.ServiceCommonHeaders.applicationJSON,
                         forHTTPHeaderField: ServicesConstants.ServiceCommonHeaders.acceptKey)
        
        //Executing Request
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                Logger.callServiceError.error("Get movie videos error: \(error.localizedDescription)")
                handler(.failure(.unknownError(error)))
                return
            }
            
            //Handling Response
            let httpResposne = response as! HTTPURLResponse
            guard case 200..<300 = httpResposne.statusCode else {
                Logger.callServiceError.error("Get movie videos error: \(httpResposne.statusCode)")
                handler(.failure(.serviceFailure(httpResposne.statusCode)))
                return
            }
            
            guard let data = data else {
                Logger.dataError.error("Get movie videos error: Missing Data")
                handler(.failure(.emptyResponse))
                return
            }
            
            let serviceResponse: VideosResponse
            
            //Parsing Data
            do {
                serviceResponse = try JSONDecoder().decode(VideosResponse.self, from: data)
            } catch {
                Logger.castError.error("Movie videos casting error: \(error.localizedDescription)")
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.invalidResponse(error, json)))
                return
            }

            handler(.success(serviceResponse))
        }
        task.resume()
    }
    
    
}
