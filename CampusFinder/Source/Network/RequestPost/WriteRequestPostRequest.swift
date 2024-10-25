//
//  WriteRequestPostRequest.swift
//  CampusFinder
//
//  Created by 강석호 on 10/25/24.
//

import Foundation
import UIKit

struct WriteRequestPostRequest {
    let categoryType: String
    let title: String
    let money: Int
    let isUrgent: Bool
    let content: String
    let deadline: String
    let meetingType: String
    let isNegotiable: Bool
    let uploadImages: [UIImage]
}
