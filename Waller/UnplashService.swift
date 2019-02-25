//
//  UnplashService.swift
//  Waller
//
//  Created by Leonardo de Matos Souza on 5/26/17.
//  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.

import Foundation
import Moya
import Alamofire

let BASE_URL = "https://api.unsplash.com/"
let CLIENT_ID = "82acb689fad50cfcaa115b2d531f8f355480c8711b827edc09c59e658b8bb38d"

public enum UnplashService {
    case Photos(page: Int, perPage: Int)
    case Profile(userName: String)
}

extension UnplashService: TargetType {
    
    public var baseURL: URL { return URL(string: BASE_URL)! }
    
    public var path: String {
        switch self {
        case .Photos:
            return "photos"
            
        case .Profile(let userName):
            return "users/\(userName)"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .Photos, .Profile:
            return .get
        }
    }
    public var parameters: [String: Any] {
        switch self {
        case .Photos(let page, let perPage):
            return ["page": page, "per_page": perPage]
        case .Profile:
            return [:]
        }
    }
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var task: Task {
        switch self {
        case .Photos, .Profile:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .Photos, .Profile:
            return "{\"msg\":\"OK\"}}".data(using: String.Encoding.utf8)!
        }
    }
    
    public var headers: [String: String]? {
        return ["Authorization": "Client-ID \(CLIENT_ID)", "X-Per-Page": "30"]
    }
}
let endpointClosure = { (target: UnplashService) -> Endpoint in
    switch target {
    default:
        let endpoint: Endpoint = Endpoint(
            url: url(route: target),
            sampleResponseClosure: {.networkResponse(200, target.sampleData)},
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers)
        
        return endpoint
    }
}

func url(route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
