//
//  PhoneNumberCertifyView.swift
//  CampusFinder
//
//  Created by 강석호 on 8/11/24.
//

import UIKit
import SnapKit

final class PhoneNumberCertifyView: BaseView {
    
    let phoneLabel = UILabel()
    let nextButton = CFButton.mainButton(title: "다음")
    
    override func configureHierarchy() {
        addSubview(phoneLabel)
        addSubview(nextButton)
    }
    
    override func configureUI() {
        phoneLabel.text = "핸드폰 번호 인증 화면"
        phoneLabel.textColor = .black
        phoneLabel.font = .systemFont(ofSize: 15)
    }
    
    override func configureConstraints() {
        phoneLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(60)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
    }
}
