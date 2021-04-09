//
//  SearchModel.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

public final class SearchModel: StatefulModel, SubscribableModel {
    public var state: State = .initial {
        didSet {
            NotificationCenter.default.post(name: Notifications.stateChanged, object: nil)
        }
    }
    
    public var words: [Word]? {
        switch state {
        case .result(let words):
            return words
        default:
            return nil
        }
    }
    
    private let service: SearchService
    
    public init(service: SearchService) {
        self.service = service
    }
    
    public func search(string: String) {
        guard !string.isEmpty else {
            state = .initial
            return
        }
        
        state = .loading
        
        let request = SearchRequest(search: string)
        service.doRequest(request) { words, error in
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
    
    public func subscribe(_ observer: SearchModelObserver) {
        NotificationCenter.default.addObserver(
            observer,
            selector: #selector(observer.stateDidChange),
            name: Notifications.stateChanged,
            object: nil
        )
        
        observer.stateDidChange()
    }
    
    public func unsubscribe(_ observer: SearchModelObserver) {
        NotificationCenter.default.removeObserver(observer)
    }
    
    public enum State: Equatable {
        case initial
        case loading
        case emptyResult
        case result(_ words: [Word])
        case error(_ error: Error)
        
        public static func == (lhs: SearchModel.State, rhs: SearchModel.State) -> Bool {
            switch (lhs, rhs) {
            case (.initial, .initial), (.loading, .loading), (.emptyResult, .emptyResult), (.error, .error):
                return true
            case (.result(let lhsWords), .result(let rhsWords)):
                return lhsWords == rhsWords
            default:
                return false
            }
        }
    }
    
    private enum Notifications {
        static let stateChanged = NSNotification.Name("SearchModel.stateChanged")
        static let responseReceived = NSNotification.Name("SearchModel.responseReceived")
    }
}

@objc
public protocol SearchModelObserver: class {
    
    @objc
    func stateDidChange()
    
}
