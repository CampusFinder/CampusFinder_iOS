//
//  WritePortfolioViewModel.swift
//  CampusFinder
//
//  Created by 강석호 on 9/8/24.
//

import Foundation

class WritePortfolioViewModel {
    
    enum NearSchool: String {
        case residence = "거주중 입니다"
        case nonResidence = "거주중이 아닙니다"
    }
    
    enum QuestMethod: String {
        case faceToFace = "대면"
        case nonFaceToFace = "비대면"
        case dontCare = "상관없음"
    }
    
    var selectedNearSchool: NearSchool? {
        didSet {
            nearSchoolDidChange?(selectedNearSchool)
        }
    }
    
    var selectedQuestMethod: QuestMethod? {
        didSet {
            questMethodDidChange?(selectedQuestMethod)
        }
    }
    
    var selectedCategory: String? {
        didSet {
            categoryDidChange?(selectedCategory)
        }
    }
    
    var categoryDidChange: ((String?) -> Void)?
    var questMethodDidChange: ((QuestMethod?) -> Void)?
    var nearSchoolDidChange: ((NearSchool?) -> Void)?
    
    let categories = ["디자인", "문서작성", "개발", "영상", "외국어", "기타"]
    
    func selectCategory(_ category: String) {
        selectedCategory = category
    }
    
    func selectQuestMethod(_ method: QuestMethod) {
        selectedQuestMethod = method
    }
    
    func selectNearSchool(_ method: NearSchool) {
        selectedNearSchool = method
    }
}
