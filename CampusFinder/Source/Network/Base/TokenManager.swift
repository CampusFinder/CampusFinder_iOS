//
//  TokenManager.swift
//  CampusFinder
//
//  Created by 강석호 on 10/4/24.
//

import Foundation

final class TokenManager {
    
    private enum TokenKey: String {
        case access
        case refresh
    }
    
    static let shared = TokenManager()
    
    private init() { }
    
    var token: String {
        get {
            UserDefaults.standard.string(forKey: TokenKey.access.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: TokenKey.access.rawValue)
        }
    }
    
    var refreshToken: String {
        get {
            UserDefaults.standard.string(forKey: TokenKey.refresh.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: TokenKey.refresh.rawValue)
        }
    }
}
