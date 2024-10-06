//
//  ChattingDummyData.swift
//  CampusFinder
//
//  Created by 강석호 on 9/30/24.
//

import Foundation
import UIKit

struct ChattingDummyData {
    let type: String
    let profileImageUrl: String
    let nickname: String
    let lastChatting: String
}

struct ChattingDummy {
    let dummy = [ChattingDummyData(type: "고용",
                                   profileImageUrl: "aaaa",
                                   nickname: "화양리 보안관",
                                   lastChatting: "언제오세요?"),
                 ChattingDummyData(type: "의뢰",
                                   profileImageUrl: "bbbb",
                                   nickname: "디자이너지망생",
                                   lastChatting: "거의 다 끝나가요!"),
                 ChattingDummyData(type: "고용",
                                   profileImageUrl: "aaaa",
                                   nickname: "이임생",
                                   lastChatting: "제가 사퇴할게요,,"),
                 ChattingDummyData(type: "의뢰",
                                   profileImageUrl: "bbbb",
                                   nickname: "학정냥이",
                                   lastChatting: "냐옹냐냐냥"),
                 ChattingDummyData(type: "고용",
                                   profileImageUrl: "aaaa",
                                   nickname: "묻지마사린마",
                                   lastChatting: "언제까지 가능하세요?"),
                 ChattingDummyData(type: "의뢰",
                                   profileImageUrl: "bbbb",
                                   nickname: "막걸리좋아",
                                   lastChatting: "얼마인가요?"),
                 ChattingDummyData(type: "고용",
                                   profileImageUrl: "aaaa",
                                   nickname: "화양리",
                                   lastChatting: "배고픈데,,"),
                 ChattingDummyData(type: "의뢰",
                                   profileImageUrl: "bbbb",
                                   nickname: "고수님",
                                   lastChatting: "이 돈으로는 안됩니다")
    ]
}
