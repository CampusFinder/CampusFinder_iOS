//
//  CFPriceView.swift
//  CampusFinder
//
//  Created by 강석호 on 9/9/24.
//

import UIKit
import SnapKit

class CFPriceView: BaseView {
    
    let textField = UITextField()
    let wonLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(textField)
        addSubview(wonLabel)
    }
    
    override func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        
        textField.font = .pretendard(size: 16, weight: .semibold)
        textField.textColor = .black
        textField.placeholder = "금액을 입력하세요"
        textField.addLeftPadding()
        textField.keyboardType = .numberPad
        
        wonLabel.text = "원"
        wonLabel.font = .pretendard(size: 14, weight: .regular)
        wonLabel.textColor = CFColor.black04
    }
    
    override func configureConstraints() {
        wonLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(13)
            make.width.equalTo(13)
            make.height.equalTo(18)
        }
        
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.verticalEdges.equalToSuperview()
            make.trailing.equalTo(wonLabel.snp.leading).offset(10)
        }
    }
}
