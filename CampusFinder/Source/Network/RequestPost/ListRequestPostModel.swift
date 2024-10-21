//
//  ListRequestPostModel.swift
//  CampusFinder
//
//  Created by 강석호 on 10/20/24.
//

import Foundation

// MARK: 의뢰찾기 글 조회
struct ListRequestPostModel: Decodable {
    let status: Int
    let description: String
    let data: [ListRequestPostResponse]
}

struct ListRequestPostResponse: Decodable {
    let boardIdx: Int
    let title: String
    let nickname: String
    let thumbnailImage: String?
    let isUrgent: Bool
    let money: Int
    let categoryType: String
}
