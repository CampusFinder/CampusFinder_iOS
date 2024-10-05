//
//  Router.swift
//  CampusFinder
//
//  Created by 강석호 on 10/4/24.
//

import Foundation
import Alamofire

enum Router {
    case signIn(query: SignInQuery)
    case signUp(query: SignUpQuery)
    case refresh
}

extension Router: TargetType {
    var method: HTTPMethod {
        switch self {
        case .signIn:
            return .post
        case .signUp:
            return .post
        case .refresh:
            return .get
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        switch self {
        case .signIn(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        case .signUp(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        default:
            return nil
        }
    }
    
    var baseURL: String {
        return APIUrl.baseURL
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "/api/signin"
        case .signUp:
            return "/api/signup"
        case .refresh:
            return "/auth/refresh"
        }
    }
    
    var header: [String: String] {
        switch self {
        case .signIn:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
            ]
        case .signUp:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
            ]
        case .refresh:
            return [
                Header.authorization.rawValue: TokenManager.shared.token,
                Header.contentType.rawValue: Header.json.rawValue,
                Header.refresh.rawValue: TokenManager.shared.refreshToken,
            ]
        }
    }
}
