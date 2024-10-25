//
//  DetailRequestPostModel.swift
//  CampusFinder
//
//  Created by 강석호 on 10/20/24.
//

import Foundation
import UIKit

// MARK: 의뢰찾기 글 조회
struct DetailRequestPostModel: Decodable {
    let status: Int
    let description: String
    let data: DetailRequestPostResponse
}

struct DetailRequestPostResponse: Decodable {
    let boardIdx: Int
    let categoryType: String
    let title: String
    let content: String
    let money: Int
    let meetingType: String
    let deadline: String
    let nickname: String
    let profileImage: String?
    let viewCount: Int
    let imageUrls: [String]
}
