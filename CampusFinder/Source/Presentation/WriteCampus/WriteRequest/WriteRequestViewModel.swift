//
//  WriteRequestViewModel.swift
//  CampusFinder
//
//  Created by 강석호 on 9/23/24.
//

import Foundation

class WriteRequestViewModel {
    
    enum Discussion {
        case discussion
        case nonDiscussion
    }
    
    enum RightNow {
        case rightNow
        case nonRightNow
    }
    
    enum QuestMethod: String {
        case faceToFace = "대면"
        case nonFaceToFace = "비대면"
        case dontCare = "상관없음"
    }
    
    private var selectedDiscussion: Discussion = .nonDiscussion {
        didSet {
            discussionDidChange?(selectedDiscussion)
        }
    }
    
    private var selectedRightNow: RightNow = .nonRightNow {
        didSet {
            rightNowDidChange?(selectedRightNow)
        }
    }
    
    private var selectedQuestMethod: QuestMethod? {
        didSet {
            questMethodDidChange?(selectedQuestMethod)
        }
    }
    
    private var selectedCategory: String? {
        didSet {
            categoryDidChange?(selectedCategory)
        }
    }
    
    private var selectedDeadline: String? {
        didSet {
            deadlineDidChange?(selectedDeadline)
        }
    }
    
    var discussionDidChange: ((Discussion) -> Void)?
    var rightNowDidChange: ((RightNow) -> Void)?
    var categoryDidChange: ((String?) -> Void)?
    var questMethodDidChange: ((QuestMethod?) -> Void)?
    var deadlineDidChange: ((String?) -> Void)?
    
    let categories = ["디자인", "문서작성", "개발", "영상", "외국어", "기타"]
    
    func toggleDiscussion() {
        selectedDiscussion = selectedDiscussion == .discussion ? .nonDiscussion : .discussion
    }
    
    func toggleRightNow() {
        selectedRightNow = selectedRightNow == .rightNow ? .nonRightNow : .rightNow
    }
    
    func selectCategory(_ category: String) {
        selectedCategory = category
    }
    
    func selectQuestMethod(_ method: QuestMethod) {
        selectedQuestMethod = method
    }
    
    func selectDeadline(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        selectedDeadline = dateFormatter.string(from: date)
    }
}
