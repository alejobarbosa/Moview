//
//  BaseManager.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 25/04/22.
//

import Foundation

protocol IBaseManager: AnyObject {
    func fetchFavorites(handler: @escaping (Result<[MovieCD], Error>) -> Void)
    func saveFavorite(id: Int,
                      overview: String,
                      posterPath: String,
                      releaseDate: String,
                      title: String,
                      voteAverage: Double,
                      handler: @escaping (Result<MovieCD, Error>) -> Void)
    func removeFavorite(id: Int, handler: @escaping (Bool) -> Void)
}
class BaseManager: IBaseManager {
    var comunicationManager = ComunicationManager()
    var coreDataManager = CoreDataManager()
    
    init(comunicationManager: ComunicationManager, coreDataManager: CoreDataManager){
        self.comunicationManager = comunicationManager
        self.coreDataManager = coreDataManager
    }
    
    func fetchFavorites(handler: @escaping (Result<[MovieCD], Error>) -> Void){
        coreDataManager.fetchFavorites(handler: handler)
    }
    
    func saveFavorite(id: Int,
                      overview: String,
                      posterPath: String,
                      releaseDate: String,
                      title: String,
                      voteAverage: Double,
                      handler: @escaping (Result<MovieCD, Error>) -> Void){
        coreDataManager.saveFavorite(id: id,
                                     overview: overview,
                                     posterPath: posterPath,
                                     releaseDate: releaseDate,
                                     title: title,
                                     voteAverage: voteAverage,
                                     handler: handler)
    }
    
    func removeFavorite(id: Int, handler: @escaping (Bool) -> Void){
        coreDataManager.removeFavorite(id: id, handler: handler)
    }
}
