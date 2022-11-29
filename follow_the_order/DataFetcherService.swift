//
//  DataFetcherService.swift
//  follow_the_order
//
//  Created by Oleksandr Khalypa on 29.11.2022.
//

import Foundation

protocol DataServiseProtocol {
    func fetchFortune(completion: @escaping (Fortune?) -> Void)
}

class DataFetcherService: DataServiseProtocol {
    
    var networkDataFetcher: DataFetcher
    
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func fetchFortune(completion: @escaping (Fortune?) -> Void) {
        let urlString = "http://yerkee.com/api/fortune"
        networkDataFetcher.fetchGenericJSONData(urlString: urlString, response: completion)
    }
    
}
