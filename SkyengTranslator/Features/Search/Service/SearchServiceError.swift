//
//  SearchServiceError.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

enum SearchServiceError: Error {
    case networkError(_ underlyingError: Error)
    case serializationError
}
