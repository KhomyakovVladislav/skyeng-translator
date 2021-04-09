//
//  SerializationTests.swift
//  SkyengTranslatorFrameworkTests
//
//  Created by Vladislav Khomyakov on 09.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import XCTest
@testable import SkyengTranslatorFramework

class SerializationTests: XCTestCase {

    private var words: [Word]!
    private var meaning: Meaning!
    private var meaningDetails: [MeaningDetails]!
    
    override func setUpWithError() throws {
        super.setUp()
        
        words = try JSONDecoder().decode([Word].self, from: getData(fromJSON: "words-array"))
        meaning = try JSONDecoder().decode(Meaning.self, from: getData(fromJSON: "meaning"))
        meaningDetails = try JSONDecoder().decode([MeaningDetails].self, from: getData(fromJSON: "meaning-details"))
    }
    
    func testWordsArraySerialization() throws {
        XCTAssertEqual(words.count, 15)
        XCTAssertEqual(
            words.map { $0.text },
            [
                "test",
                "test match",
                "rundown test",
                "bump test",
                "test protocol",
                "test run",
                "test stand",
                "test-taker",
                "test rig",
                "mental test",
                "intelligence test",
                "engine test",
                "patch test",
                "test drive",
                "psychometric test"
            ]
        )
        XCTAssertEqual(
            words.map { $0.meanings.count },
            [11, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2]
        )
    }
    
    func testMeaningSerialization() throws {
        XCTAssertEqual(meaning.id, 9044)
        XCTAssertEqual(meaning.partOfSpeechCode, .noun)
        XCTAssertEqual(meaning.translation, Translation(text: "тест", note: ""))
        XCTAssertEqual(meaning.transcription, "tɛst")
    }
    
    func testMeaningDetailsSerialization() throws {
        XCTAssertNotNil(meaningDetails.first)
        
        let meaningDetails = self.meaningDetails.first!
        
        XCTAssertEqual(meaningDetails.partOfSpeechCode, .noun)
        XCTAssertEqual(meaningDetails.prefix, "a")
        XCTAssertEqual(meaningDetails.text, "test")
        XCTAssertEqual(meaningDetails.transcription, "tɛst")
        XCTAssertEqual(meaningDetails.translation, Translation(text: "тест", note: ""))
        
        XCTAssertNotNil(meaningDetails.images.first)
        
        var components = URLComponents(string: meaningDetails.images.first!.url)
        components?.scheme = "https"
        XCTAssertNotNil(components?.url)
        
        XCTAssertEqual(meaningDetails.definition.text, "Any standardized procedure for measuring sensitivity or memory, or intelligence, or personality, etc.")
        
        XCTAssertEqual(meaningDetails.examples.count, 3)
    }

}
