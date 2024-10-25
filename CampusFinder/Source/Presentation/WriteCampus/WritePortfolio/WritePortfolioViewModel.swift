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
    
    var title: String = ""
    var content: String = ""
    
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
    
    // 카테고리 매핑 딕셔너리 추가
    private let categoryTypeMapping = [
        "디자인": "DESIGN",
        "문서작성": "DOCS",
        "개발": "DEV",
        "영상": "VIDEO",
        "외국어": "LANGUAGE",
        "기타": "ETC"
    ]
    
    // 만남 방식 매핑
    private let meetingTypeMapping = [
        QuestMethod.faceToFace: "FACE_TO_FACE",
        QuestMethod.nonFaceToFace: "NONE_FACE_TO_FACE",
        QuestMethod.dontCare: "NOTHING"
    ]
    
    var categoryDidChange: ((String?) -> Void)?
    var questMethodDidChange: ((QuestMethod?) -> Void)?
    var nearSchoolDidChange: ((NearSchool?) -> Void)?
    
    let categories = ["디자인", "문서작성", "개발", "영상", "외국어", "기타"]
    
    // 입력값 유효성 검사
    func validateInputs() -> (isValid: Bool, message: String?) {
        if selectedCategory == nil {
            return (false, "서비스를 선택해주세요")
        }
        
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return (false, "제목을 입력해주세요")
        }
        
        if selectedQuestMethod == nil {
            return (false, "진행방식을 선택해주세요")
        }
        
        if selectedNearSchool == nil {
            return (false, "학교 근처 거주 여부를 선택해주세요")
        }
        
        if content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return (false, "의뢰내용을 입력해주세요")
        }
        
        return (true, nil)
    }
    
    func selectCategory(_ category: String) {
        selectedCategory = category
    }
    
    func selectQuestMethod(_ method: QuestMethod) {
        selectedQuestMethod = method
    }
    
    func selectNearSchool(_ method: NearSchool) {
        selectedNearSchool = method
    }
    
    // 포트폴리오 작성 요청
    func writePortfolio(completion: @escaping (Result<Void, Error>) -> Void) {
            guard let category = selectedCategory,
                  let categoryType = categoryTypeMapping[category],
                  let questMethod = selectedQuestMethod,
                  let meetingType = meetingTypeMapping[questMethod] else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid input data"])))
                return
            }
            
            // 요청 데이터 로깅
            print("==== Portfolio Write Request ====")
            print("Category: \(category) -> \(categoryType)")
            print("Title: \(title)")
            print("IsNearCampus: \(selectedNearSchool == .residence)")
            print("MeetingType: \(questMethod) -> \(meetingType)")
            print("Content: \(content)")
            print("=============================")
            
            let request = WritePortfolioRequest(
                categoryType: categoryType,
                title: title,
                isNearCampus: selectedNearSchool == .residence,
                meetingType: meetingType,
                content: content,
                uploadImages: [] // 이미지 추가 기능은 아직 구현하지 않음
            )
            
            StudentPostNetworkManager.shared.writePortfolio(request: request) { result in
                print("==== API Response ====")
                switch result {
                case .success:
                    print("Portfolio write success")
                case .failure(let error):
                    print("Portfolio write failed: \(error.localizedDescription)")
                    print("Error details: \(error)")
                }
                print("=====================")
                
                completion(result)
            }
        }
}
