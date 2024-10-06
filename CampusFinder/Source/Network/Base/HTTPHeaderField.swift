//
//  HTTPHeaderField.swift
//  CampusFinder
//
//  Created by 강석호 on 10/4/24.
//

import Foundation

enum Header: String {
    case authorization = "Authorization"
    case refresh = "Refresh"
    case contentType = "Content-Type"
    case json = "application/json"
    case multipart = "multipart/form-data"
}
