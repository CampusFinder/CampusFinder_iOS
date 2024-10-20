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
    case emailSend(query: EmailSendQuery)
    case emailVerify(query: EmailVerifyQuery)
    case smsSend(query: SMSSendQuery)
    case smsVerify(query: SMSVerifyQuery)
    case nicknameVerify(query: NicknameVerifyQuery)
    case passwordVerify(query: PasswordVerifyQuery)
    case listStudentPost(categoryType: String)
    case refresh
}

extension Router: TargetType {
    var method: HTTPMethod {
        switch self {
        case .signIn:
            return .post
        case .signUp:
            return .post
        case .emailSend:
            return .post
        case .emailVerify:
            return .post
        case .smsSend:
            return .post
        case .smsVerify:
            return .post
        case .nicknameVerify:
            return .post
        case .passwordVerify:
            return .post
        case .refresh:
            return .get
        case .listStudentPost:
            return .get
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .listStudentPost(let categoryType):
            return [URLQueryItem(name: "categoryType", value: categoryType)]
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .signIn(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        case .signUp(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        case .emailSend(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        case .emailVerify(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        case .smsSend(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        case .smsVerify(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        case .nicknameVerify(let query):
            let encoder = JSONEncoder()
            return try? encoder.encode(query)
        case .passwordVerify(let query):
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
        case .emailSend:
            return "/api/certification/email/send"
        case .emailVerify:
            return "/api/certification/email/verify"
        case .smsSend:
            return "/api/certification/sms/send"
        case .smsVerify:
            return "/api/certification/sms/verify"
        case .nicknameVerify:
            return "/api/signup/nickname-check"
        case .passwordVerify:
            return "/api/signup/password-check"
        case .refresh:
            return "/auth/refresh"
        case .listStudentPost:
            return "/api/student-board/list"
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
        case .emailSend:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
            ]
        case .emailVerify:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
            ]
        case .smsSend:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
            ]
        case .smsVerify:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
            ]
        case .nicknameVerify:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
            ]
        case .passwordVerify:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
            ]
        case .listStudentPost:
            return [
                Header.authorization.rawValue: TokenManager.shared.token,
                Header.contentType.rawValue: Header.json.rawValue,
                Header.refresh.rawValue: TokenManager.shared.refreshToken
            ]
        case .refresh:
            return [
                Header.authorization.rawValue: TokenManager.shared.token,
                Header.contentType.rawValue: Header.json.rawValue,
                Header.refresh.rawValue: TokenManager.shared.refreshToken
            ]
        }
    }
}
