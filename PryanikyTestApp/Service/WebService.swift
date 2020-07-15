//
//  WebService.swift
//  PryanikyTestApp
//
//  Created by rau4o on 7/15/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import Moya

enum WebService {
    case getData
}

extension WebService: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://pryaniky.com/static/json/sample.json") else { fatalError("OPS") }
        return url
    }
    
    var path: String {
        switch self {
        case .getData:
            return ""
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
            case .getData:
                return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

