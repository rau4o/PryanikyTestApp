//
//  DataFetcherService.swift
//  PryanikyTestApp
//
//  Created by rau4o on 7/15/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import Foundation

class DataFetcherService {
    var networkDataFetcher: NetworkManagerDelegate

    init(networkDataFetcher: NetworkManagerDelegate = NetworkManager()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func fetchData(completion: @escaping (Welcome?) -> Void) {
        networkDataFetcher.fetchGenericJSONData(target: .getData, response: completion)
    }
}
