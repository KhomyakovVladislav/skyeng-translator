//
//  SearchService.swift
//  SkyengTranslator
//
//  Created by Vladislav Khomyakov on 08.04.2021.
//  Copyright © 2021 Vladislav Khomyakov. All rights reserved.
//

import Foundation

public class SearchService: Service {
    public typealias RequestType = SearchRequest
    public typealias ResponseType = [Word]
    
    private let url: URL = {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = Constants.host
        components.path = Constants.path
        
        return components.url!
    }()
    
    public init() {
        
    }
    
    public func doRequest(_ request: SearchRequest, _ completion: (([Word]?, ServiceError?) -> Void)?) {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        components.queryItems = [
            URLQueryItem(name: "search", value: request.search)
        ]
        
        var urlRequest = URLRequest(url: components.url!)
        
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion?(nil, .networkError(error))
                }
                
                return
            }
            
            guard let data = data,
                let words = try? JSONDecoder().decode([Word].self, from: data) else {
                    DispatchQueue.main.async {
                        completion?(nil, .serializationError)
                    }
                    return
            }
            
            DispatchQueue.main.async {
                completion?(words, nil)
            }
        }.resume()
    }
    
    private enum Constants {
        static let host = "dictionary.skyeng.ru"
        static let path = "/api/public/v1/words/search"
    }
}
