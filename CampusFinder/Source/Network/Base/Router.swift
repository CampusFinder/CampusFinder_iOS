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
    case listRequestPost(categoryType: String)
    case detailStudentPost(boardIdx: Int)
    case detailRequestPost(boardIdx: Int)
    case writePortfolio(request: WritePortfolioRequest)
    case writeRequestPost(request: WriteRequestPostRequest)
    case refresh
    case userInfo
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
        case .listRequestPost:
            return .get
        case .detailStudentPost:
            return .get
        case .detailRequestPost:
            return .get
        case .writePortfolio:
            return .post
        case .writeRequestPost:
            return .post
        case .userInfo:
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
        case .listRequestPost(let categoryType):
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
            return "/api/student-post/list"
        case .listRequestPost:
            return "/api/request-post/list"
        case .detailStudentPost(let boardIdx):
            return "/api/student-post/detail/\(boardIdx)"
        case .detailRequestPost(let boardIdx):
            return "/api/request-post/detail/\(boardIdx)"
        case .writePortfolio:
            return "/api/student-post"
        case .writeRequestPost:
            return "/api/request-post"
        case .userInfo:
            return "/api/users/info"
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
        case .listRequestPost:
            return [
                Header.authorization.rawValue: TokenManager.shared.token,
                Header.contentType.rawValue: Header.json.rawValue,
                Header.refresh.rawValue: TokenManager.shared.refreshToken
            ]
        case .detailStudentPost:
            return [
                Header.authorization.rawValue: "Bearer \(TokenManager.shared.token)",
                Header.contentType.rawValue: Header.json.rawValue,
                //                Header.refresh.rawValue: TokenManager.shared.refreshToken
            ]
        case .detailRequestPost:
            return [
                Header.authorization.rawValue: "Bearer \(TokenManager.shared.token)",
                Header.contentType.rawValue: Header.json.rawValue,
                //                Header.refresh.rawValue: TokenManager.shared.refreshToken
            ]
        case .refresh:
            return [
                Header.authorization.rawValue: TokenManager.shared.token,
                Header.contentType.rawValue: Header.json.rawValue,
                Header.refresh.rawValue: TokenManager.shared.refreshToken
            ]
        case .writePortfolio:
            return [
                Header.authorization.rawValue: "Bearer \(TokenManager.shared.token)",
                Header.contentType.rawValue: Header.multipart.rawValue
            ]
        case .writeRequestPost:
            return [
                Header.authorization.rawValue: "Bearer \(TokenManager.shared.token)",
                Header.contentType.rawValue: Header.multipart.rawValue
            ]
        case .userInfo:
            return [
                Header.authorization.rawValue: "Bearer \(TokenManager.shared.token)",
                Header.contentType.rawValue: Header.json.rawValue
            ]
        }
    }
    
    var multipartFormData: MultipartFormData? {
        switch self {
        case .writePortfolio(let request):
            let formData = MultipartFormData()
            
            // 각 필드를 개별적으로 추가
            if let categoryTypeData = request.categoryType.data(using: .utf8) {
                formData.append(categoryTypeData, withName: "categoryType")
                print("Added categoryType: \(request.categoryType)")
            }
            
            if let titleData = request.title.data(using: .utf8) {
                formData.append(titleData, withName: "title")
                print("Added title: \(request.title)")
            }
            
            let isNearCampusString = String(request.isNearCampus)
            if let isNearCampusData = isNearCampusString.data(using: .utf8) {
                formData.append(isNearCampusData, withName: "isNearCampus")
                print("Added isNearCampus: \(isNearCampusString)")
            }
            
            if let meetingTypeData = request.meetingType.data(using: .utf8) {
                formData.append(meetingTypeData, withName: "meetingType")
                print("Added meetingType: \(request.meetingType)")
            }
            
            if let contentData = request.content.data(using: .utf8) {
                formData.append(contentData, withName: "content")
                print("Added content: \(request.content)")
            }
            
            // 이미지가 있다면 이미지도 추가
            for (index, image) in request.uploadImages.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 0.7) {
                    formData.append(
                        imageData,
                        withName: "uploadImages",
                        fileName: "image\(index + 1).jpg",
                        mimeType: "image/jpeg"
                    )
                    print("Added image \(index + 1)")
                }
            }
            
            return formData
            
        case .writeRequestPost(let request):
            let formData = MultipartFormData()
            
            if let categoryTypeData = request.categoryType.data(using: .utf8) {
                formData.append(categoryTypeData, withName: "categoryType")
            }
            
            if let titleData = request.title.data(using: .utf8) {
                formData.append(titleData, withName: "title")
            }
            
            let moneyString = String(request.money)
            if let moneyData = moneyString.data(using: .utf8) {
                formData.append(moneyData, withName: "money")
            }
            
            let isUrgentString = String(request.isUrgent)
            if let isUrgentData = isUrgentString.data(using: .utf8) {
                formData.append(isUrgentData, withName: "isUrgent")
            }
            
            if let contentData = request.content.data(using: .utf8) {
                formData.append(contentData, withName: "content")
            }
            
            if let deadlineData = request.deadline.data(using: .utf8) {
                formData.append(deadlineData, withName: "deadline")
            }
            
            if let meetingTypeData = request.meetingType.data(using: .utf8) {
                formData.append(meetingTypeData, withName: "meetingType")
            }
            
            let isNegotiableString = String(request.isNegotiable)
            if let isNegotiableData = isNegotiableString.data(using: .utf8) {
                formData.append(isNegotiableData, withName: "isNegotiable")
            }
            
            // 이미지 추가
            for (index, image) in request.uploadImages.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 0.7) {
                    formData.append(
                        imageData,
                        withName: "uploadImages",
                        fileName: "image\(index + 1).jpg",
                        mimeType: "image/jpeg"
                    )
                }
            }
            
            return formData
            
            
        default:
            return nil
        }
        
        
    }
}
