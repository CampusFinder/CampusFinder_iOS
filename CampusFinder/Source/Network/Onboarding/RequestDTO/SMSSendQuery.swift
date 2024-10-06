//
//  SMSSendQuery.swift
//  CampusFinder
//
//  Created by 강석호 on 10/5/24.
//

import Foundation

// MARK: 휴대폰 SMS 인증번호 전송
struct SMSSendQuery: Encodable {
    let phoneNum: String
    let email: String
}
