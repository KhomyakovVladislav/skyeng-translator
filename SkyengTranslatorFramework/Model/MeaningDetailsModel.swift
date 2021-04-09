//
//  MeaningDetailsModel.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

public final class MeaningDetailsModel: StatefulModel, SubscribableModel {
    public typealias StateType = State
    public typealias ObserverType = MeaningDetailsModelObserver
    
    public var state: State = .loading {
        didSet {
            NotificationCenter.default.post(name: Notifications.stateChanged, object: nil)
        }
    }
    
    public init(meaningId: MeaningId, meaningDetailsService: MeaningDetailsService, imageService: ImageService) {
        
        meaningDetailsService.doRequest(meaningId) { meanings, error in
            if let error = error {
                self.state = .error(error)
                return
            }
            
            guard let meaning = meanings?.first else {
                self.state = .noData
                return
            }
            
            self.state = .result(meaning, nil)
            
            guard let urlString = meaning.images.first?.url else {
                return
            }
            
            var components = URLComponents(string: urlString)
            components?.scheme = "https"
            
            guard let url = components?.url else {
                self.state = .result(meaning, nil)
                return
            }
            
            imageService.doRequest(url) { (data, error) in
                if let error = error {
                    self.state = .error(error)
                    return
                }
                
                self.state = .result(meaning, data)
            }
        }
    }
    
    public func subscribe(_ observer: MeaningDetailsModelObserver) {
        NotificationCenter.default.addObserver(
            observer,
            selector: #selector(observer.stateDidChange),
            name: Notifications.stateChanged,
            object: nil
        )
        
        observer.stateDidChange()
    }
    
    public func unsubscribe(_ observer: MeaningDetailsModelObserver) {
        NotificationCenter.default.removeObserver(observer)
    }
    
    public enum State {
        case loading
        case noData
        case result(MeaningDetails, Data?)
        case error(Error)
    }
    
    private enum Notifications {
        static let stateChanged = NSNotification.Name("MeaningDetailsModel.stateChanged")
    }
}

@objc
public protocol MeaningDetailsModelObserver: class {
    
    @objc
    func stateDidChange()
    
}
