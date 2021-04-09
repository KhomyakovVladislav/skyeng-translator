//
//  ImageService.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

class ImageService: Service {
    typealias RequestType = URL
    typealias ResponseType = Data
    
    func doRequest(_ url: URL, _ completion: ((Data?, ServiceError?) -> Void)?) {
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    completion?(data, nil)
                }
            }
            catch {
                completion?(nil, .networkError(error))
            }
        }
    }
}
