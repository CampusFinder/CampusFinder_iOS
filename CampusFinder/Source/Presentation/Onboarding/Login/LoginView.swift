//
//  LoginView.swift
//  CampusFinder
//
//  Created by 강석호 on 8/10/24.
//

import UIKit
import SnapKit

final class LoginView: BaseView {
    
    let logoImageView = UIImageView()
    let phoneNumberField = UITextField()
    let phoneNumberLine = CFLine.lightGrayLine()
    let passwordField = UITextField()
    let passwordLine = CFLine.lightGrayLine()
    let loginButton = CFButton.primaryButton(title: "로그인")
    let joinButton = UIButton()
    let primaryLine = CFLine.primaryLine()
    let findPasswordButton = UIButton()
    
    let buttonStackView = UIStackView()
    
    override func configureHierarchy() {
        addSubview(logoImageView)
        addSubview(phoneNumberField)
        addSubview(phoneNumberLine)
        addSubview(passwordField)
        addSubview(passwordLine)
        addSubview(loginButton)
        
        buttonStackView.addArrangedSubview(joinButton)
        buttonStackView.addArrangedSubview(primaryLine)
        buttonStackView.addArrangedSubview(findPasswordButton)
        
        addSubview(buttonStackView)
    }
    
    override func configureUI() {
        logoImageView.image = UIImage(named: "onboardingLogo")
        logoImageView.contentMode = .scaleAspectFit
        
        phoneNumberField.placeholder = "휴대폰 번호를 입력하세요"
        phoneNumberField.backgroundColor = .clear
        phoneNumberField.keyboardType = .numberPad
        
        passwordField.placeholder = "비밀번호를 입력하세요"
        passwordField.backgroundColor = .clear
        
        joinButton.setTitle("회원가입", for: .normal)
        joinButton.setTitleColor(CFColor.black01, for: .normal)
        joinButton.titleLabel?.font = .pretendard(size: 14, weight: .medium)
        joinButton.backgroundColor = .clear
        
        findPasswordButton.setTitle("비밀번호 찾기", for: .normal)
        findPasswordButton.setTitleColor(CFColor.black01, for: .normal)
        findPasswordButton.titleLabel?.font = .pretendard(size: 14, weight: .medium)
        findPasswordButton.backgroundColor = .clear
        
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 10
        buttonStackView.alignment = .center
        buttonStackView.distribution = .fillProportionally
    }
    
    override func configureConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(180)
            make.horizontalEdges.equalToSuperview().inset(75)
            make.height.equalTo(77)
        }
        
        phoneNumberField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(63)
            make.horizontalEdges.equalToSuperview().inset(67)
            make.height.equalTo(30)
        }
        
        phoneNumberLine.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberField.snp.bottom).offset(2)
            make.horizontalEdges.equalToSuperview().inset(67)
            make.height.equalTo(1)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLine.snp.bottom).offset(23)
            make.horizontalEdges.equalToSuperview().inset(67)
            make.height.equalTo(30)
        }
        
        passwordLine.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(2)
            make.horizontalEdges.equalToSuperview().inset(67)
            make.height.equalTo(1)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordLine.snp.bottom).offset(36)
            make.horizontalEdges.equalToSuperview().inset(67)
            make.height.equalTo(53)
        }
        
        primaryLine.snp.makeConstraints { make in
            make.width.equalTo(2)
            make.height.equalTo(buttonStackView.snp.height)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
    }
}
