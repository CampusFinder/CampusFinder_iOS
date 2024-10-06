//
//  SMSVerifyQuery.swift
//  CampusFinder
//
//  Created by 강석호 on 10/5/24.
//

import Foundation

// MARK: 휴대폰 SMS 인증번호 검증
struct SMSVerifyQuery: Encodable {
    let phoneNum: String
    let code: String
}
