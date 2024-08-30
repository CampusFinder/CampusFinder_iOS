//
//  CFButton.swift
//  CampusFinder
//
//  Created by 강석호 on 8/10/24.
//

import UIKit

class CFButton {
    static func mainButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(CFColor.black04, for: .normal)
        button.backgroundColor = CFColor.Bg.gray03
        button.layer.cornerRadius = 10
        return button
    }
}
