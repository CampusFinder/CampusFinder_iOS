//
//  EmailSendQuery.swift
//  CampusFinder
//
//  Created by 강석호 on 10/5/24.
//

import Foundation

// MARK: 이메일 전송
struct EmailSendQuery: Encodable {
    let role: String
    let email: String
    let univName: String
}
