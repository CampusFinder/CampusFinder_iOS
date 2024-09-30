//
//  CategoryCase.swift
//  CampusFinder
//
//  Created by 강석호 on 9/30/24.
//

import Foundation

enum CategoryCase: String, CaseIterable {
    case all = "전체"
    case design = "디자인"
    case document = "문서작성"
    case develop = "개발"
    case video = "영상"
    case foreign = "외국어"
    case ect = "기타"
    
    var dummyData: [CategoryCaseDummyData] {
        switch self {
        case .all:
            return [
                CategoryCaseDummyData(title: "디자인 의뢰를 해드립니다 정말로 고수입니다ㅋㅋ", nickname: "화양리 보안관", isNearSchool: true),
                CategoryCaseDummyData(title: "강아지 사진 그려드립니다ㅎㅎ", nickname: "김선생", isNearSchool: true),
                CategoryCaseDummyData(title: "다양한 고양이 의뢰를 해드립니다", nickname: "젠지 화이팅", isNearSchool: false),
                CategoryCaseDummyData(title: "얼굴 그려드립니다 😥", nickname: "용원게이", isNearSchool: false),
                CategoryCaseDummyData(title: "다양한 디자인 의뢰를 해드립니다1111111", nickname: "흑백요리사", isNearSchool: false),
                CategoryCaseDummyData(title: "다양한 디자인 의뢰를 해드립니다222222", nickname: "안성재쉪", isNearSchool: true)
            ]
        case .design:
            return [
                CategoryCaseDummyData(title: "디자인 의뢰를 해드립니다 정말로 고수입니다ㅋㅋ", nickname: "화양리 보안관", isNearSchool: true),
                CategoryCaseDummyData(title: "강아지 사진 그려드립니다ㅎㅎ", nickname: "김선생", isNearSchool: true),
                CategoryCaseDummyData(title: "다양한 고양이 의뢰를 해드립니다", nickname: "젠지 화이팅", isNearSchool: false),
                CategoryCaseDummyData(title: "얼굴 그려드립니다 😥", nickname: "용원게이", isNearSchool: false),
                CategoryCaseDummyData(title: "다양한 디자인 의뢰를 해드립니다1111111", nickname: "흑백요리사", isNearSchool: false),
                CategoryCaseDummyData(title: "다양한 디자인 의뢰를 해드립니다222222", nickname: "안성재쉪", isNearSchool: true)
            ]
        case .document:
            return [
                CategoryCaseDummyData(title: "디자인 의뢰를 해드립니다 정말로 고수입니다ㅋㅋ", nickname: "화양리 보안관", isNearSchool: true),
                CategoryCaseDummyData(title: "강아지 사진 그려드립니다ㅎㅎ", nickname: "김선생", isNearSchool: true),
                CategoryCaseDummyData(title: "다양한 고양이 의뢰를 해드립니다", nickname: "젠지 화이팅", isNearSchool: false),
                CategoryCaseDummyData(title: "얼굴 그려드립니다 😥", nickname: "용원게이", isNearSchool: false),
                CategoryCaseDummyData(title: "다양한 디자인 의뢰를 해드립니다1111111", nickname: "흑백요리사", isNearSchool: false),
                CategoryCaseDummyData(title: "다양한 디자인 의뢰를 해드립니다222222", nickname: "안성재쉪", isNearSchool: true)
            ]
        case .develop:
            return [
                CategoryCaseDummyData(title: "디자인 의뢰를 해드립니다 정말로 고수입니다ㅋㅋ", nickname: "화양리 보안관", isNearSchool: true),
                CategoryCaseDummyData(title: "강아지 사진 그려드립니다ㅎㅎ", nickname: "김선생", isNearSchool: true),
                CategoryCaseDummyData(title: "다양한 고양이 의뢰를 해드립니다", nickname: "젠지 화이팅", isNearSchool: false),
                CategoryCaseDummyData(title: "얼굴 그려드립니다 😥", nickname: "용원게이", isNearSchool: false),
                CategoryCaseDummyData(title: "다양한 디자인 의뢰를 해드립니다1111111", nickname: "흑백요리사", isNearSchool: false),
                CategoryCaseDummyData(title: "다양한 디자인 의뢰를 해드립니다222222", nickname: "안성재쉪", isNearSchool: true)
            ]
        case .video:
            return [
                CategoryCaseDummyData(title: "디자인 의뢰를 해드립니다 정말로 고수입니다ㅋㅋ", nickname: "화양리 보안관", isNearSchool: true),
                CategoryCaseDummyData(title: "강아지 사진 그려드립니다ㅎㅎ", nickname: "김선생", isNearSchool: true),
                CategoryCaseDummyData(title: "다양한 고양이 의뢰를 해드립니다", nickname: "젠지 화이팅", isNearSchool: false),
                CategoryCaseDummyData(title: "얼굴 그려드립니다 😥", nickname: "용원게이", isNearSchool: false),
                CategoryCaseDummyData(title: "다양한 디자인 의뢰를 해드립니다1111111", nickname: "흑백요리사", isNearSchool: false),
                CategoryCaseDummyData(title: "다양한 디자인 의뢰를 해드립니다222222", nickname: "안성재쉪", isNearSchool: true)
            ]
        case .foreign:
            return [
                CategoryCaseDummyData(title: "디자인 의뢰를 해드립니다 정말로 고수입니다ㅋㅋ", nickname: "화양리 보안관", isNearSchool: true),
                CategoryCaseDummyData(title: "강아지 사진 그려드립니다ㅎㅎ", nickname: "김선생", isNearSchool: true),
                CategoryCaseDummyData(title: "다양한 고양이 의뢰를 해드립니다", nickname: "젠지 화이팅", isNearSchool: false),
                CategoryCaseDummyData(title: "얼굴 그려드립니다 😥", nickname: "용원게이", isNearSchool: false),
                CategoryCaseDummyData(title: "다양한 디자인 의뢰를 해드립니다1111111", nickname: "흑백요리사", isNearSchool: false),
                CategoryCaseDummyData(title: "다양한 디자인 의뢰를 해드립니다222222", nickname: "안성재쉪", isNearSchool: true)
            ]
        case .ect:
            return [
                CategoryCaseDummyData(title: "디자인 의뢰를 해드립니다 정말로 고수입니다ㅋㅋ", nickname: "화양리 보안관", isNearSchool: true),
                CategoryCaseDummyData(title: "강아지 사진 그려드립니다ㅎㅎ", nickname: "김선생", isNearSchool: true),
                CategoryCaseDummyData(title: "다양한 고양이 의뢰를 해드립니다", nickname: "젠지 화이팅", isNearSchool: false),
                CategoryCaseDummyData(title: "얼굴 그려드립니다 😥", nickname: "용원게이", isNearSchool: false),
                CategoryCaseDummyData(title: "다양한 디자인 의뢰를 해드립니다1111111", nickname: "흑백요리사", isNearSchool: false),
                CategoryCaseDummyData(title: "다양한 디자인 의뢰를 해드립니다222222", nickname: "안성재쉪", isNearSchool: true)
            ]
        }
    }
}

struct CategoryCaseDummyData {
    let title: String
    let nickname: String
    let isNearSchool: Bool
}
