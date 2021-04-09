//
//  SearchModel.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

protocol StatefulModel {
    associatedtype StateType
    
    var state: StateType { get }
}

protocol SubscribableModel {
    associatedtype ObserverType
    
    func subscribe(_ observer: ObserverType)
    func unsubscribe(_ observer: ObserverType)
}

final class SearchModel: StatefulModel, SubscribableModel {
    private(set) var state: State = .initial {
        didSet {
            NotificationCenter.default.post(name: Notifications.stateChanged, object: nil)
        }
    }
    
    var words: [Word]? {
        switch state {
        case .result(let words):
            return words
        default:
            return nil
        }
    }
    
    private let service: SearchService
    
    init(service: SearchService) {
        self.service = service
    }
    
    func search(string: String) {
        guard !string.isEmpty else {
            state = .initial
            return
        }
        
        state = .loading
        
        service.doRequest(string) { words, error in
            if let error = error {
                self.state = .error(error)
                return
            }
            
            guard let words = words, !words.isEmpty else {
                self.state = .emptyResult
                return
            }
            
            self.state = .result(words)
        }
    }
    
    func subscribe(_ observer: SearchModelObserver) {
        NotificationCenter.default.addObserver(
            observer,
            selector: #selector(observer.stateDidChange),
            name: Notifications.stateChanged,
            object: nil
        )
        
        observer.stateDidChange()
    }
    
    func unsubscribe(_ observer: SearchModelObserver) {
        NotificationCenter.default.removeObserver(observer)
    }
    
    enum State {
        case initial
        case loading
        case emptyResult
        case result(_ words: [Word])
        case error(_ error: Error)
    }
    
    private enum Notifications {
        static let stateChanged = NSNotification.Name("SearchModel.stateChanged")
    }
}

@objc
public protocol SearchModelObserver: class {
    
    @objc
    func stateDidChange()
    
}
