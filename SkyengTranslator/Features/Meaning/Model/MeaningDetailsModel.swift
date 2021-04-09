//
//  MeaningDetailsModel.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

final class MeaningDetailsModel: StatefulModel, SubscribableModel {
    typealias StateType = State
    typealias ObserverType = MeaningDetailsModelObserver
    
    private(set) var state: State = .loading {
        didSet {
            NotificationCenter.default.post(name: Notifications.stateChanged, object: nil)
        }
    }
    
    init(meaningId: Int, meaningDetailsService: MeaningDetailsService, imageService: ImageService) {
        
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
//            components?.queryItems = [
//                URLQueryItem(name: "w", value: "450"),
//                URLQueryItem(name: "h", value: "250"),
//                URLQueryItem(name: "q", value: "50")
//            ]
            
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
    
    func subscribe(_ observer: MeaningDetailsModelObserver) {
        NotificationCenter.default.addObserver(
            observer,
            selector: #selector(observer.stateDidChange),
            name: Notifications.stateChanged,
            object: nil
        )
        
        observer.stateDidChange()
    }
    
    func unsubscribe(_ observer: MeaningDetailsModelObserver) {
        NotificationCenter.default.removeObserver(observer)
    }
    
    enum State {
        case loading
        case noData
        case result(MeaningEx, Data?)
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
