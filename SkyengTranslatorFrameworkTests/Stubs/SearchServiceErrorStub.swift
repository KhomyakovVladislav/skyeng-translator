//
//  SearchServiceErrorStub.swift
//  SkyengTranslatorFrameworkTests
//
//  Created by Vladislav Khomyakov on 09.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation
@testable import SkyengTranslatorFramework

class SearchServiceErrorStub: SearchService {
    override func doRequest(_ request: SearchRequest, _ completion: (([Word]?, ServiceError?) -> Void)?) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            DispatchQueue.main.async {
                completion?(nil, ServiceError.serializationError)
            }
        }
    }
}
