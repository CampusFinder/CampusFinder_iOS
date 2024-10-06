//
//  PasswordVerifyModel.swift
//  CampusFinder
//
//  Created by 강석호 on 10/5/24.
//

import Foundation

// MARK: 비밀번호 유효성 검사
struct PasswordVerifyModel: Decodable {
    let status: Int
    let description: String
}
