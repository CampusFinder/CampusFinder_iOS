//
//  CFLine.swift
//  CampusFinder
//
//  Created by 강석호 on 8/30/24.
//

import UIKit

class CFLine {
    static func lightGrayLine() -> UIView {
        let view = UIView()
        view.backgroundColor = CFColor.Bg.gray04
        return view
    }
    
    static func primaryLine() -> UIView {
        let view = UIView()
        view.backgroundColor = CFColor.Primary.blue03
        return view
    }
}
