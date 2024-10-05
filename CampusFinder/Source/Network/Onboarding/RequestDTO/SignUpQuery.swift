//
//  SignUpQuery.swift
//  CampusFinder
//
//  Created by 강석호 on 10/4/24.
//

import Foundation

// MARK: 회원가입
struct SignUpQuery: Encodable {
    let role: String
    let email: String
    let phoneNum: String
    let password: String
    let nickname: String
    let univName: String
}
