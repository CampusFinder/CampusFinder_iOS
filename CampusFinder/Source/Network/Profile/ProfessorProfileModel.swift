//
//  ProfessorProfileModel.swift
//  CampusFinder
//
//  Created by 이빈 on 12/14/24.
//

struct ProfessorProfileModel: Decodable {
    let status: Int
    let description: String
    let data: ProfessorData
}

struct ProfessorData: Decodable {
    let profileImageUrl: String?
    let nickname: String
    let workDays: [String]
    let startTime: Int
    let endTime: Int
}
