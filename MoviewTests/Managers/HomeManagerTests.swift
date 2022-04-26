//
//  HomeManagerTests.swift
//  MoviewTests
//
//  Created by Luis Alejandro Barbosa Lee on 25/04/22.
//

import Foundation
import XCTest
@testable import Moview

class HomeManagerTests: BaseTests {
    //MARK: - Common values
    enum Constants {
        static let popularMoviesJSON = "MockPopularMoviesResponse"
    }
    enum ExpectedValues {
        static let moviesCount = 2
    }
    
    //MARK: Test Variables
    let mockComunicationManager = MockComunicationManager()
    let coreDataManager = CoreDataManager()
    var movieCDTests = MovieCD()
    
    override func setUp() {
            print("\n")
            print("setUp")
    }
        
    override func tearDown() {
        print("Tear down")
        print("\n")
    }
    
    //MARK: Test Get Popular Movies
    ///Test success response
    func testA_GetPopularMovies_withMoviesSuccessResponse_moviesArray() {
        let data = getData(fromJSONFile: Constants.popularMoviesJSON)
        mockComunicationManager.data = data ?? Data()
        
        let manager = HomeManager(comunicationManager: mockComunicationManager,
                                  coreDataManager: coreDataManager)
        manager.getPopularMovies(page: 1) { (response) in
            switch response {
            case.success(let movies):
                XCTAssertEqual(movies.results?.count, ExpectedValues.moviesCount)
                break
            case .failure:
                XCTFail()
                break
            }
        }
    }
    
    ///Test failure response
    func testB_PopularMovies_withMoviesFailureResponse_emptyMoviesArray() {
        mockComunicationManager.shouldReturnError = true
        
        let manager = HomeManager(comunicationManager: mockComunicationManager,
                                  coreDataManager: coreDataManager)
        manager.getPopularMovies(page: 1) { (response) in
            switch response {
            case.success(_):
                XCTFail()
                break
            case .failure(let error):
                XCTAssertNotNil(error)
                break
            }
        }
    }
    
    //MARK: Test Get Favorite Movies (Not Nil)
    ///Test success response - array not nil
    func testC_FetchFavorites_withFavoritesSuccessResponse_notNilFavoritesArray() {
        let manager = HomeManager(comunicationManager: mockComunicationManager,
                                  coreDataManager: coreDataManager)
        manager.fetchFavorites { (response) in
            switch response {
            case.success(let movies):
                XCTAssertNotNil(movies)
                break
            case .failure:
                XCTFail()
                break
            }
        }
    }
    
    //MARK: Test Save Favorite Movie
    ///Test success response
    func testD_SavaFavorite_withSaveSuccessResponse_notNilFavorite() {
        let manager = HomeManager(comunicationManager: mockComunicationManager,
                                  coreDataManager: coreDataManager)
        manager.saveFavorite(id: 1,
                             overview: "",
                             posterPath: "",
                             releaseDate: "",
                             title: "",
                             voteAverage: 10.0,
                             handler: {  (response) in
            switch response {
            case.success(let movieCD):
                self.movieCDTests = movieCD
                XCTAssertNotNil(movieCD)
                XCTAssertEqual(movieCD.id, 1)
                break
            case .failure:
                XCTFail()
                break
            }
        })
    }
    
    //MARK: Test Get Favorite Movies (Not Empty)
    ///Test success response - array not empty
    func testE_FetchFavorites_withFavoritesSuccessResponse_notEmptyFavoritesArray() {
        let manager = HomeManager(comunicationManager: mockComunicationManager,
                                  coreDataManager: coreDataManager)
        manager.fetchFavorites { (response) in
            switch response {
            case.success(let movies):
                XCTAssertFalse(movies.isEmpty)
                break
            case .failure:
                XCTFail()
                break
            }
        }
    }
    
    //MARK: Test Remove Favorite Movie
    ///Test success response
    func testF_RemoveFavorite_withRemoveSuccessResponse() {
        let manager = HomeManager(comunicationManager: mockComunicationManager,
                                  coreDataManager: coreDataManager)
        manager.removeFavorite(id: 1,
                               handler: { (success) in
            XCTAssert(success)
        })
    }
    
    ///Test failure response
    func testG_RemoveFavorite_withRemoveFailureResponse() {
        let manager = HomeManager(comunicationManager: mockComunicationManager,
                                  coreDataManager: coreDataManager)
        manager.removeFavorite(id: 0,
                               handler: { (success) in
            XCTAssertFalse(success)
        })
    }
}
