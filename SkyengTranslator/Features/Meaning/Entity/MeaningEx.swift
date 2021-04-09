//
//  MeaningEx.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

struct MeaningEx: Decodable {
    let partOfSpeechCode: SpeechPart
    let prefix: String?
    let text: String
    let transcription: String
    let translation: Translation
    let images: [ImageUrl]
    let definition: Text
    let examples: [Text]
    
    struct Text: Decodable {
        let text: String
    }
    
    struct ImageUrl: Decodable {
        let url: String
    }
}

