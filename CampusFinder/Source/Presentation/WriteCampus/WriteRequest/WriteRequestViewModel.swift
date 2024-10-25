//
//  WriteRequestViewModel.swift
//  CampusFinder
//
//  Created by 강석호 on 9/23/24.
//

import Foundation
import UIKit

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
    var title: String = ""
    var content: String = ""
    var money: Int = 0
    
    private let categoryTypeMapping = [
        "디자인": "DESIGN",
        "문서작성": "DOCS",
        "개발": "DEV",
        "영상": "VIDEO",
        "외국어": "LANGUAGE",
        "기타": "ETC"
    ]
    
    var selectedImages: [UIImage] = []
    
    private let meetingTypeMapping = [
        QuestMethod.faceToFace: "FACE_TO_FACE",
        QuestMethod.nonFaceToFace: "NONE_FACE_TO_FACE",
        QuestMethod.dontCare: "NOTHING"
    ]
    
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
    
    func validateInputs() -> (isValid: Bool, message: String?) {
        if selectedCategory == nil {
            return (false, "서비스를 선택해주세요")
        }
        
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return (false, "제목을 입력해주세요")
        }
        
        if money <= 0 {
            return (false, "제시금액을 입력해주세요")
        }
        
        if selectedDeadline == nil && selectedRightNow == .nonRightNow {
            return (false, "마감기한을 선택하거나 당장구함을 선택해주세요")
        }
        
        if selectedQuestMethod == nil {
            return (false, "진행방식을 선택해주세요")
        }
        
        if content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return (false, "의뢰내용을 입력해주세요")
        }
        
        return (true, nil)
    }
    
    func writeRequest(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let category = selectedCategory,
              let categoryType = categoryTypeMapping[category],
              let questMethod = selectedQuestMethod,
              let meetingType = meetingTypeMapping[questMethod] else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid input data"])))
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let deadline: String
        if selectedRightNow == .rightNow {
            deadline = dateFormatter.string(from: Date())
        } else {
            guard let deadlineStr = selectedDeadline else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid deadline"])))
                return
            }
            
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            guard let date = dateFormatter.date(from: deadlineStr) else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid date format"])))
                return
            }
            
            dateFormatter.dateFormat = "yyyy-MM-dd"
            deadline = dateFormatter.string(from: date)
        }
        
        let request = WriteRequestPostRequest(
            categoryType: categoryType,
            title: title,
            money: money,
            isUrgent: selectedRightNow == .rightNow,
            content: content,
            deadline: deadline,
            meetingType: meetingType,
            isNegotiable: selectedDiscussion == .discussion,
            uploadImages: selectedImages
        )
        
        RequestPostNetworkManager.shared.writeRequestPost(request: request, completion: completion)
    }
}
