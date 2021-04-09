//
//  Service.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

public protocol Service {
    associatedtype RequestType
    associatedtype ResponseType
    
    func doRequest(_ req: RequestType, _ completion: ((ResponseType?, ServiceError?) -> Void)?)
}
