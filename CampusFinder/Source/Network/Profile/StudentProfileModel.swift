//
//  StudentProfileModel.swift
//  CampusFinder
//
//  Created by 이빈 on 12/14/24.
//

struct StudentProfileModel: Decodable {
    let status: Int
    let description: String
    let data: StudentData
}

struct StudentData: Decodable {
    let profileImageUrl: String?
    let nickname: String
    let introduction: String?
}
