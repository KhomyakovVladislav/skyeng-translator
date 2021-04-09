//
//  MeaningEx.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

public struct MeaningDetails: Decodable {
    public let partOfSpeechCode: SpeechPart
    public let prefix: String?
    public let text: String
    public let transcription: String
    public let translation: Translation
    public let images: [ImageUrl]
    public let definition: Text
    public let examples: [Text]
    
    public struct Text: Decodable {
        public let text: String
    }
    
    public struct ImageUrl: Decodable {
        public let url: String
    }
}

