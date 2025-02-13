//
//  UserInfoModel.swift
//  CampusFinder
//
//  Created by 이빈 on 12/13/24.
//

import Foundation

struct UserInfoModel: Decodable {
    let status: Int
    let description: String
    let data: UserData
}

struct UserData: Decodable {
    let userIdx: Int
    let phoneNum: String
    let role: String
    let email: String
    let nickname: String
    let univName: String
}
