//
//  SelectPositionView.swift
//  CampusFinder
//
//  Created by 강석호 on 8/11/24.
//

import UIKit
import SnapKit

final class SelectPositionView: BaseView {
    
    let termsLabel = UILabel()
    let nextButton = CFButton.primaryButton(title: "다음")
    
    override func configureHierarchy() {
        addSubview(termsLabel)
        addSubview(nextButton)
    }
    
    override func configureUI() {
        termsLabel.text = "교수 학생 선택 화면"
        termsLabel.textColor = .black
        termsLabel.font = .systemFont(ofSize: 15)
    }
    
    override func configureConstraints() {
        termsLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(60)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
    }
}
