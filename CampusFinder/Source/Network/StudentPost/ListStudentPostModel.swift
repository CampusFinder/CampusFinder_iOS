//
//  ListStudentPostModel.swift
//  CampusFinder
//
//  Created by 강석호 on 10/20/24.
//

import Foundation

// MARK: 학생찾기 글 조회
struct ListStudentPostModel: Decodable {
    let status: Int
    let description: String
    let data: [ListStudentPostResponse]
}

struct ListStudentPostResponse: Decodable {
    let boardIdx: Int
    let title: String
    let nickname: String
    let thumbnailImage: String?
    let isNearCampus: Bool
    let categoryType: String
}
