//
//  LoginView.swift
//  CampusFinder
//
//  Created by 강석호 on 8/10/24.
//

import UIKit
import SnapKit

final class LoginView: BaseView {
    
    let phoneNumberField = UITextField()
    let passwordField = UITextField()
    let loginButton = CFButton.mainButton(title: "로그인")
    let joinButton = CFButton.mainButton(title: "회원가입")
    
    override func configureHierarchy() {
        addSubview(phoneNumberField)
        addSubview(passwordField)
        addSubview(loginButton)
        addSubview(joinButton)
    }
    
    override func configureUI() {
        phoneNumberField.placeholder = "휴대폰 번호를 입력하세요"
        phoneNumberField.layer.borderColor = UIColor.black.cgColor
        phoneNumberField.layer.borderWidth = 0.5
        phoneNumberField.layer.cornerRadius = 10
        phoneNumberField.keyboardType = .numberPad
        
        passwordField.placeholder = "비밀번호를 입력하세요"
        passwordField.layer.borderColor = UIColor.black.cgColor
        passwordField.layer.borderWidth = 0.5
        passwordField.layer.cornerRadius = 10
    }
    
    override func configureConstraints() {
        phoneNumberField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-60)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        joinButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(100)
            make.horizontalEdges.equalToSuperview().inset(80)
            make.height.equalTo(44)
        }
    }
}
