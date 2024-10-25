//
//  WritePortfolioRequest.swift
//  CampusFinder
//
//  Created by 강석호 on 10/25/24.
//

import Foundation
import UIKit

struct WritePortfolioRequest {
    let categoryType: String
    let title: String
    let isNearCampus: Bool
    let meetingType: String
    let content: String
    let uploadImages: [UIImage]  // String 배열에서 UIImage 배열로 변경
}
