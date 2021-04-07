//
//  Service.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

protocol Service {
    associatedtype RequestType
    associatedtype ResponseType
    associatedtype ErrorType: Error
    
    var url: URL { get }
    
    func doRequest(_ req: RequestType, _ completion: ((ResponseType?, ErrorType?) -> Void)?)
}
