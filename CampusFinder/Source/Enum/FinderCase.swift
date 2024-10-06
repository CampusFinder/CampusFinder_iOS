//
//  CategoryCase.swift
//  CampusFinder
//
//  Created by 강석호 on 8/30/24.
//

import Foundation

enum FinderCase: String, CaseIterable {
    case student = "학생찾기"
    case request = "의뢰찾기"
    
    var dummyData: [DummyData] {
        switch self {
        case .student:
            return [
                DummyData(title: "디자인 의뢰를 해드립니다 정말로 고수입니다ㅋㅋ", nickname: "화양리 보안관", isNearSchool: true, price: nil),
                DummyData(title: "강아지 사진 그려드립니다ㅎㅎ", nickname: "김선생", isNearSchool: true, price: nil),
                DummyData(title: "다양한 고양이 의뢰를 해드립니다", nickname: "젠지 화이팅", isNearSchool: false, price: nil),
                DummyData(title: "얼굴 그려드립니다 😥", nickname: "용원게이", isNearSchool: false, price: nil),
                DummyData(title: "다양한 디자인 의뢰를 해드립니다1111111", nickname: "흑백요리사", isNearSchool: false, price: nil),
                DummyData(title: "다양한 디자인 의뢰를 해드립니다222222", nickname: "안성재쉪", isNearSchool: true, price: nil)
            ]
        case .request:
            return [
                DummyData(title: "지금 학교에서 ppt 화면 제작해주실 분 구해요~!", nickname: "고수임니다", isNearSchool: true, price: "1000000원"),
                DummyData(title: "지금 학교에서 ppt 화면 제작ㄱ", nickname: "화양리 보안관", isNearSchool: true, price: "1000000원"),
                DummyData(title: "지금 학교에서 ppt 화면 제작해주실 분 구해요~!", nickname: "앵무새사용자", isNearSchool: false, price: "1000000원"),
                DummyData(title: "지금 학교에서 ppt 화면 제작해주실 분 구해요~!", nickname: "김가네존맛", isNearSchool: false, price: "1000000원"),
                DummyData(title: "지금 학교에서 ppt 만들자", nickname: "이원복", isNearSchool: true, price: "1000000원"),
                DummyData(title: "지금 학교에서 ppt 화면 제작해주실 분 구해요~!", nickname: "아버지생신", isNearSchool: true, price: "1000000원")
            ]
        }
    }
}
struct DummyData {
    let title: String
    let nickname: String
    let isNearSchool: Bool
    let price: String?  // 학생찾기에는 price가 없고, 의뢰찾기에는 값이 들어감
}
