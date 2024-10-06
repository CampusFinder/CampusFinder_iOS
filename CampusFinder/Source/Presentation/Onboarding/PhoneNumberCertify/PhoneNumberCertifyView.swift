//
//  PhoneNumberCertifyView.swift
//  CampusFinder
//
//  Created by 강석호 on 8/11/24.
//

import UIKit
import SnapKit

class PhoneNumberCertifyView: BaseView {
    
    let phoneNumberTitle = UILabel()
    let phoneNumberTextField = UITextField()
    let phoneNumberLine = CALayer()
    let sendButton = UIButton()
    let certifyNumberTextField = UITextField()
    let certifyNumberLine = CALayer()
    let confirmButton = UIButton()
    let nextButton = CFButton.grayButton(title: "다음")
    
    override func configureHierarchy() {
        addSubview(phoneNumberTitle)
        addSubview(phoneNumberTextField)
        addSubview(certifyNumberTextField)
        addSubview(nextButton)
    }
    
    override func configureUI() {
        phoneNumberTitle.font = .pretendard(size: 18, weight: .semibold)
        phoneNumberTitle.text = "휴대폰 번호"
        phoneNumberTitle.textColor = .black
        
        phoneNumberTextField.backgroundColor = .clear
        phoneNumberTextField.placeholder = "휴대폰 번호를 입력하세요"
        phoneNumberTextField.textAlignment = .left
        phoneNumberTextField.textColor = .black
        phoneNumberTextField.keyboardType = .numberPad
        
        sendButton.setTitle("전송", for: .normal)
        sendButton.setTitleColor(CFColor.black02, for: .normal)
        sendButton.titleLabel?.font = .pretendard(size: 16, weight: .medium)

        phoneNumberTextField.rightView = sendButton
        phoneNumberTextField.rightViewMode = .always
        
        phoneNumberLine.backgroundColor = CFColor.Bg.gray04.cgColor
        phoneNumberTextField.layer.addSublayer(phoneNumberLine)
        
        certifyNumberTextField.backgroundColor = .clear
        certifyNumberTextField.placeholder = "전송된 인증번호를 입력하세요"
        certifyNumberTextField.textAlignment = .left
        certifyNumberTextField.textColor = .black
        
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.setTitleColor(CFColor.black02, for: .normal)
        confirmButton.titleLabel?.font = .pretendard(size: 16, weight: .medium)

        certifyNumberTextField.rightView = confirmButton
        certifyNumberTextField.rightViewMode = .always
        
        certifyNumberLine.backgroundColor = CFColor.Bg.gray04.cgColor
        certifyNumberTextField.layer.addSublayer(certifyNumberLine)
    }
    
    override func configureConstraints() {
        phoneNumberTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(167)
            make.leading.equalToSuperview().inset(16)
        }
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTitle.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        certifyNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(60)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        phoneNumberLine.frame = CGRect(
            x: 0,
            y: phoneNumberTextField.frame.size.height - 1,
            width: phoneNumberTextField.frame.size.width,
            height: 1
        )
        
        certifyNumberLine.frame = CGRect(
            x: 0,
            y: certifyNumberTextField.frame.size.height - 1,
            width: certifyNumberTextField.frame.size.width,
            height: 1
        )
    }
}
