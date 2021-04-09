//
//  SearchModelTests.swift
//  SkyengTranslatorFrameworkTests
//
//  Created by Vladislav Khomyakov on 09.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

import XCTest
@testable import SkyengTranslatorFramework

class SearchModelTests: XCTestCase {

    func testInitialState() throws {
        let service = SearchServiceMockDataStub()
        let model = SearchModel(service: service)
        
        XCTAssertEqual(model.state, .initial)
    }
    
    func testFallbackToInitialState() throws {
        let service = SearchServiceMockDataStub()
        let model = SearchModel(service: service)
        
        model.search(string: "")
        
        XCTAssertEqual(model.state, .initial)
    }
    
    func testLoadingState() throws {
        let service = SearchServiceMockDataStub()
        let model = SearchModel(service: service)
        
        model.search(string: "test")
        
        XCTAssertEqual(model.state, .loading)
    }
    
    func testEmptyResultState() throws {
        let service = SearchServiceMockDataStub()
        let model = SearchModel(service: service)
        let expectation = self.expectation(forNotification: Notification.Name(rawValue: "SearchModel.stateChanged"), object: nil) { _ -> Bool in
            return model.state == .emptyResult
        }
        
        model.search(string: "test")
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testNonEmptyResultState() throws {
        let mockData = try JSONDecoder().decode([Word].self, from: getData(fromJSON: "words-array"))
        let service = SearchServiceMockDataStub(mockData: mockData)
        let model = SearchModel(service: service)
        let expectation = self.expectation(forNotification: Notification.Name(rawValue: "SearchModel.stateChanged"), object: nil) { _ -> Bool in
            return model.state == .result(mockData)
        }
        
        model.search(string: "test")
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testSerializationErrorState() throws {
        let service = SearchServiceErrorStub()
        let model = SearchModel(service: service)
        let expectation = self.expectation(forNotification: Notification.Name(rawValue: "SearchModel.stateChanged"), object: nil) { _ -> Bool in
            return model.state == .error(ServiceError.serializationError)
        }
        
        model.search(string: "test")
        
        wait(for: [expectation], timeout: 1.0)
    }
}
