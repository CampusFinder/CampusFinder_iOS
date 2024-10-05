//
//  SignInModel.swift
//  CampusFinder
//
//  Created by 강석호 on 10/4/24.
//

import Foundation
import Alamofire

// MARK: 로그인
struct SignInModel: Decodable {
    let status: Int
    let description: String
    let data: SignInResponse
}

struct SignInResponse: Decodable {
    let userIdx: Int
    let accessToken: String
    let refreshToken: String
}
