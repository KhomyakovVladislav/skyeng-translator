//
//  Meaning.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

struct Meaning: Decodable {
    let id: Int
    let partOfSpeechCode: SpeechPart
    let translation: Translation
    let transcription: String
}
