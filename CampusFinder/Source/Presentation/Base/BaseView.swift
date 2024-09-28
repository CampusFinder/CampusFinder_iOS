//
//  BaseView.swift
//  CampusFinder
//
//  Created by 강석호 on 8/7/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureConstraints()
        configureUI()
        configureAddTarget()
    }
    
    func configureHierarchy() { }
    func configureConstraints() { }
    func configureUI() { }
    func configureAddTarget() { }
    
    func createAttributedText(fullText: String, coloredText: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: fullText)
        if let range = fullText.range(of: coloredText) {
            let nsRange = NSRange(range, in: fullText)
            let color = CFColor.Primary.blue01
            attributedString.addAttribute(.foregroundColor, value: color, range: nsRange)
        }
        return attributedString
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
