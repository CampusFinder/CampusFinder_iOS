//
//  EmailSendModel.swift
//  CampusFinder
//
//  Created by 강석호 on 10/5/24.
//

import Foundation
import Alamofire

// MARK: 회원가입
struct EmailSendModel: Decodable {
    let status: Int
    let description: String
}
