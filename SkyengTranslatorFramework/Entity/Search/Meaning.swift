//
//  Meaning.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

public struct Meaning: Decodable, Equatable {
    public let id: Int
    public let partOfSpeechCode: SpeechPart
    public let translation: Translation
    public let transcription: String
}
