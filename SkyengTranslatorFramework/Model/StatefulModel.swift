//
//  StatefulModel.swift
//  SkyengTranslatorFramework
//
//  Created by Vladislav Khomyakov on 09.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

public protocol StatefulModel {
    associatedtype StateType
    
    var state: StateType { get }
}
