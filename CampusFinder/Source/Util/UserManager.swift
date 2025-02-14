//
//  UserManager.swift
//  CampusFinder
//
//  Created by 이빈 on 12/13/24.
//

import Foundation

final class UserManager {
    static let shared = UserManager()
    
    private init() {}
    
    var userInfo: UserData?
    
    func saveUserInfo(_ userInfo: UserData) {
        self.userInfo = userInfo
    }
    
    func getUserInfo() -> UserData? {
        return userInfo
    }
    
    func clearUserInfo() {
        self.userInfo = nil
    }
}
