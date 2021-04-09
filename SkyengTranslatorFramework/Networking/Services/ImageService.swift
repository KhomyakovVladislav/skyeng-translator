//
//  ImageService.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

public class ImageService: Service {
    public typealias RequestType = URL
    public typealias ResponseType = Data
    
    public init() {
        
    }
    
    public func doRequest(_ url: URL, _ completion: ((Data?, ServiceError?) -> Void)?) {
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
