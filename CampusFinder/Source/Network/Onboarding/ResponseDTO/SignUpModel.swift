//
//  SignUpModel.swift
//  CampusFinder
//
//  Created by 강석호 on 10/4/24.
//

import Foundation
import Alamofire

// MARK: 회원가입
struct SignUpModel: Decodable {
    let status: Int
    let description: String
}
