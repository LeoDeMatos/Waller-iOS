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
    case photos(page: Int, perPage: Int)
    case searchPhotos(query: String, page: Int, perPage: Int)
    case profile(userName: String)
}

extension UnplashService: TargetType {
    
    public var baseURL: URL { return URL(string: BASE_URL)! }
    
    public var path: String {
        switch self {
        case .photos:
            return "photos"
            
        case .profile(let userName):
            return "users/\(userName)"
    
        case .searchPhotos:
            return "search/photos"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .photos, .profile, .searchPhotos:
            return .get
        }
    }
    public var parameters: [String: Any] {
        switch self {
        case .photos(let page, let perPage):
            return ["page": page, "per_page": perPage]
    
        case .profile:
            return [:]
            
        case .searchPhotos(let query, let page, let perPage):
            return ["query": query, "page": page, "per_page": perPage]
        }
    }
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var task: Task {
        switch self {
        case .photos, .profile, .searchPhotos:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .photos, .searchPhotos:
            return JSONProvider.provideJsonFor(path: "photo_array").data(using: .utf8)!
            
        case .profile:
            return JSONProvider.provideJsonFor(path: "profile").data(using: .utf8)!
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
