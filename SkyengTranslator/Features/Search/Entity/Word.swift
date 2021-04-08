//
//  Word.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

struct Word: Decodable {
    let id: Int
    let text: String
    let meanings: [Meaning]
}
