//
//  WriteRequestView.swift
//  CampusFinder
//
//  Created by 강석호 on 9/5/24.
//

import UIKit
import SnapKit

class WriteRequestView: BaseView {
    
    let containerView = UIView()
    let scrollView = UIScrollView()
    
    let serviceLabel = UILabel()
    let serviceView = CFSelectView()
    let serviceButton = UIButton()
    let titleLabel = UILabel()
    let titleTextField = UITextField()
    
    override func configureHierarchy() {
        addSubview(containerView)
        containerView.addSubview(scrollView)
        
        scrollView.addSubview(serviceLabel)
        scrollView.addSubview(serviceView)
        scrollView.addSubview(serviceButton)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(titleTextField)
    }
    
    override func configureUI() {
        serviceLabel.font = .pretendard(size: 18, weight: .semibold)
        serviceLabel.textColor = CFColor.black01
        serviceLabel.attributedText = createAttributedText(fullText: "서비스*", coloredText: "*")
        
        serviceButton.backgroundColor = .clear
        
        titleLabel.font = .pretendard(size: 18, weight: .semibold)
        titleLabel.textColor = CFColor.black01
        titleLabel.attributedText = createAttributedText(fullText: "제목*", coloredText: "*")
        
        titleTextField.backgroundColor = .white
        titleTextField.layer.cornerRadius = 10
        titleTextField.addLeftPadding()
        titleTextField.placeholder = "최대 30자 입력가능"
    }
    
    override func configureConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
            make.width.equalTo(containerView.snp.width)
        }
        
        serviceLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).inset(14)
            make.leading.equalTo(containerView).inset(16)
        }
        
        serviceView.snp.makeConstraints { make in
            make.top.equalTo(serviceLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(16)
            make.height.equalTo(45)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(serviceView.snp.bottom).offset(28)
            make.leading.equalTo(containerView).inset(16)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(16)
            make.height.equalTo(45)
        }
    }
}
