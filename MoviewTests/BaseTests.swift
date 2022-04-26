//
//  MockSession.swift
//  MoviewTests
//
//  Created by Luis Alejandro Barbosa Lee on 25/04/22.
//

import XCTest
@testable import Moview

class BaseTests: XCTestCase {
    
    enum Constants {
        static let jsonExtension = "json"
        static let mockProducts = "MockProductsResponse"
        static let mockProductDetail = "MockProductDetailResponse"
    }
    
    //Process the data from mocked json files
    func getData(fromJSONFile fileName: String) -> Data? {
        guard let resourceURL = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: Constants.jsonExtension) else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: resourceURL) else {
            return nil
        }
        
        return data
    }

}
