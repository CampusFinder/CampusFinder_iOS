//
//  DetailStudentPostModel.swift
//  CampusFinder
//
//  Created by 강석호 on 10/20/24.
//

import Foundation

// MARK: 학생찾기 글 조회
struct DetailStudentPostModel: Decodable {
    let status: Int
    let description: String
    let data: DetailStudentPostResponse
}

struct DetailStudentPostResponse: Decodable {
    let boardIdx: Int
    let title: String
    let content: String
    let viewCount: Int
    let meetingType: String
    let isNearCampus: Bool
    let imageUrls: [String]
    let categoryType: String
    let nickname: String
    let profileImageUrl: String?
}
