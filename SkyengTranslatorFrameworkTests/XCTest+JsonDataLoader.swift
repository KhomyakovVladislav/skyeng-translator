//
//  XCTest+JsonData.swift
//  SkyengTranslatorFrameworkTests
//
//  Created by Vladislav Khomyakov on 09.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import XCTest

extension XCTestCase {
    enum TestError: Error {
        case fileNotFound
    }

    func getData(fromJSON fileName: String) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Missing File: \(fileName).json")
            throw TestError.fileNotFound
        }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            throw error
        }
    }
}
