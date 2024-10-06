//
//  EmailVerifyQuery.swift
//  CampusFinder
//
//  Created by 강석호 on 10/5/24.
//

import Foundation

// MARK: 이메일 인증번호 검사
struct EmailVerifyQuery: Encodable {
    let role: String
    let email: String
    let univName: String
    let code: String
}
