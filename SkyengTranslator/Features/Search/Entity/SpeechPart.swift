//
//  SpeechPart.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

enum SpeechPart: String, Decodable, CustomStringConvertible {
    case noun = "n"
    case verb = "v"
    case adjective = "j"
    case adverb = "r"
    case preposition = "prp"
    case pronoun = "prn"
    case cardinalNumber = "crd"
    case conjunction = "cjc"
    case interjection = "exc"
    case article = "det"
    case abbreviation = "abb"
    case particle = "x"
    case ordinalNumber = "ord"
    case modalVerb = "md"
    case phrase = "ph"
    case idiom = "phi"
    
    var description: String {
        switch self {
        case .noun:
            return "noun"
        case .verb:
            return "verb"
        case .adjective:
            return "adjective"
        case .adverb:
            return "adverb"
        case .preposition:
            return "preposition"
        case .pronoun:
            return "pronoun"
        case .cardinalNumber:
            return "cardinal number"
        case .conjunction:
            return "conjunction"
        case .interjection:
            return "interjection"
        case .article:
            return "article"
        case .abbreviation:
            return "abbreviation"
        case .particle:
            return "particle"
        case .ordinalNumber:
            return "ordinal number"
        case .modalVerb:
            return "modal verb"
        case .phrase:
            return "phrase"
        case .idiom:
            return "idiom"
        }
    }
}
