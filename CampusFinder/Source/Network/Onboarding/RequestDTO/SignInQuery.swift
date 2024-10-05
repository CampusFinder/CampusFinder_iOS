//
//  SignInQuery.swift
//  CampusFinder
//
//  Created by 강석호 on 10/4/24.
//

import Foundation

// MARK: 로그인
struct SignInQuery: Encodable {
    let phoneNumber: String
    let password: String
}
