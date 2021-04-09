//
//  Translation.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

public struct Translation: Decodable, Equatable {
    public let text: String
    public let note: String?
}
