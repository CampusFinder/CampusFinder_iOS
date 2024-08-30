//
//  CategoryCase.swift
//  CampusFinder
//
//  Created by 강석호 on 8/30/24.
//

import Foundation

enum CategoryCase: String, CaseIterable {
    case student = "학생찾기"
    case request = "의뢰찾기"
    
    var dummyData: [DummyData] {
        switch self {
        case .student:
            return [
                DummyData(title: "다양한 디자인 의뢰를 해드립니다", description: ""),
                DummyData(title: "다양한 디자인 의뢰를 해드립니다", description: ""),
                DummyData(title: "다양한 디자인 의뢰를 해드립니다", description: "")
            ]
        case .request:
            return [
                DummyData(title: "지금 학교에서 ppt 화면 제작해주실 분 구해요~!", description: "제시금액 1000000원"),
                DummyData(title: "지금 학교에서 ppt 화면 제작해주실 분 구해요~!", description: "제시금액 1000000원"),
                DummyData(title: "지금 학교에서 ppt 화면 제작해주실 분 구해요~!", description: "제시금액 1000000원")
            ]
        }
    }
}

struct DummyData {
    let title: String
    let description: String
}
