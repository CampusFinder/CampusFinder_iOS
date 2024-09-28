//
//  UserDefaultsManager.swift
//  CampusFinder
//
//  Created by 강석호 on 9/23/24.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    private let userDefaults = UserDefaults.standard
    
    private init() {}

    //MARK: 최근 검색어 저장
    func saveRecentKeyword(_ keyword: String) {
        var recentKeywords = loadRecentKeywords()
        
        if !recentKeywords.contains(keyword) {
            recentKeywords.append(keyword)
            userDefaults.set(recentKeywords, forKey: UserDefaultsKey.recentKeyword)
        }
    }

    //MARK: 최근 검색어 불러오기
    func loadRecentKeywords() -> [String] {
        return userDefaults.array(forKey: UserDefaultsKey.recentKeyword) as? [String] ?? []
    }
    
    //MARK: 최근 검색어 삭제
    func deleteRecentKeyword(_ keyword: String) {
        var recentKeywords = loadRecentKeywords()
        if let index = recentKeywords.firstIndex(of: keyword) {
            recentKeywords.remove(at: index)
            userDefaults.set(recentKeywords, forKey: UserDefaultsKey.recentKeyword)
        }
    }

    //MARK: 최근 검색어 전체 삭제
    func deleteAllRecentKeywords() {
        userDefaults.removeObject(forKey: UserDefaultsKey.recentKeyword)
    }
}
