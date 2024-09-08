//
//  CFButton.swift
//  CampusFinder
//
//  Created by 강석호 on 8/10/24.
//

import UIKit

class CFButton {
    static func primaryButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .pretendard(size: 16, weight: .bold)
        button.backgroundColor = CFColor.Primary.blue01
        button.layer.cornerRadius = 10
        return button
    }
    
    static func writingButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = CFColor.Primary.blue01
        button.setTitle(title, for: .normal)
        button.setTitleColor(CFColor.Primary.blue01, for: .normal)
        button.titleLabel?.font = .pretendard(size: 16, weight: .semibold)
        button.backgroundColor = CFColor.Primary.blue04
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 1
        button.layer.borderColor = CFColor.Primary.blue03.cgColor
        return button
    }
    
    static func unselectedButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(CFColor.black03, for: .normal)
        button.titleLabel?.font = .pretendard(size: 16, weight: .semibold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = CFColor.Bg.gray02.cgColor
        return button
    }
}
