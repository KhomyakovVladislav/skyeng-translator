//
//  SearchRequest.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

struct SearchRequest {
    let search: String
    let page: Int?
    let pageSize: Int?
}
