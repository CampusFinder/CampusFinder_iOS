//
//  SignupData.swift
//  CampusFinder
//
//  Created by 강석호 on 10/4/24.
//

import Foundation

class SignupData {
    static let shared = SignupData()
    
    private init() {
        reset()
    }

    var role: String?
    var nickname: String?
    var password: String?
    var phoneNumber: String?
    var univName: String?
    var email: String?
    
    func reset() {
        role = nil
        nickname = nil
        password = nil
        phoneNumber = nil
        univName = nil
        email = nil
    }
}
