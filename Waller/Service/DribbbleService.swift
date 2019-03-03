////
////  DribbbleService.swift
////  Waller
////
////  Created by Leonardo de Matos Souza on 6/15/17.
////  Copyright © 2017 Leonardo de Matos Souza. All rights reserved.
////
//
//import Foundation
//import Moya
//import Alamofire
//
//let BASE_DRIBBBLE_URL = "https://api.dribbble.com/v1/"
//let CLIENT_OAUTH_ID = "c76b236856692cc339bf4d2b9f8038f47fdad7194052b0f1bd7fa6617c021ed3"
//
//public enum DribbbleService {
//    case Shots()
//    case ShotsForUser(userId: Int)
//}
//
//extension DribbbleService: TargetType {
//
//    public var headers: [String : String]? {
//        return nil
//    }
//
//    public var baseURL: URL { return URL(string: BASE_DRIBBBLE_URL)! }
//
//    public var path: String {
//        switch self {
//        case .Shots:
//            return "shots"
//
//        case .ShotsForUser(let userId):
//            return "users/\(userId)/shots"
//        }
//    }
//    public var method: Moya.Method {
//        switch self {
//        case .Shots,
//             .ShotsForUser:
//            return .get
//        }
//    }
//    public var parameters: [String: Any]? {
//        switch self {
//        case .Shots,
//             .ShotsForUser:
//            return ["access_token": CLIENT_OAUTH_ID]
//        }
//    }
//    public var parameterEncoding: ParameterEncoding {
//        return URLEncoding.default
//    }
//    public var task: Task {
//        switch self {
//        default:
//            return .requestData
//        }
//    }
//    public var sampleData: Data {
//        switch self {
//        case .Shots,
//             .ShotsForUser:
//            return "{\"msg\":\"OK\"}}".data(using: String.Encoding.utf8)!
//        }
//    }
//}
//let dribbleEndpointClosure = { (target: DribbbleService) -> Endpoint in
//    switch target {
//    default:
//        let endpoint: Endpoint = Endpoint(
//            url: dribbbleUrl(route: target),
//            sampleResponseClosure: {.networkResponse(200, target.sampleData)},
//            method: target.method,
//            task: target.parameters,
//            httpHeaderFields: URLEncoding.default)
//
//        return endpoint
//    }
//}
//
//func dribbbleUrl(route: TargetType) -> String {
//    return route.baseURL.appendingPathComponent(route.path).absoluteString
//}
//
