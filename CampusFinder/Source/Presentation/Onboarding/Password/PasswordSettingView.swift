//
//  PasswordSettingView.swift
//  CampusFinder
//
//  Created by 강석호 on 10/3/24.
//

import UIKit
import SnapKit

class PasswordSettingView: BaseView {
    let passwordTitle = UILabel()
    let passwordTextField = UITextField()
    let passwordLine = CALayer()
    let passwordButton = UIButton()
    let passwordCheckTitle = UILabel()
    let passwordCheckTextField = UITextField()
    let passwordCheckLine = CALayer()
    let nextButton = CFButton.grayButton(title: "가입하기")
    
    override func configureHierarchy() {
        addSubview(passwordTitle)
        addSubview(passwordTextField)
        addSubview(passwordCheckTitle)
        addSubview(passwordCheckTextField)
        addSubview(nextButton)
    }
    
    override func configureUI() {
        passwordTitle.font = .pretendard(size: 18, weight: .semibold)
        passwordTitle.text = "비밀번호"
        passwordTitle.textColor = .black
        
        passwordTextField.backgroundColor = .clear
        passwordTextField.placeholder = "비밀번호를 입력하세요"
        passwordTextField.textAlignment = .left
        passwordTextField.textColor = .black
        
        passwordButton.setTitle("확인", for: .normal)
        passwordButton.setTitleColor(CFColor.black02, for: .normal)
        passwordButton.titleLabel?.font = .pretendard(size: 16, weight: .medium)

        passwordTextField.rightView = passwordButton
        passwordTextField.rightViewMode = .always
        
        passwordLine.backgroundColor = CFColor.Bg.gray04.cgColor
        passwordTextField.layer.addSublayer(passwordLine)
        
        passwordCheckTitle.font = .pretendard(size: 18, weight: .semibold)
        passwordCheckTitle.text = "비밀번호 확인"
        passwordCheckTitle.textColor = .black
        
        passwordCheckTextField.backgroundColor = .clear
        passwordCheckTextField.placeholder = "다시 비밀번호를 입력하세요"
        passwordCheckTextField.textAlignment = .left
        passwordCheckTextField.textColor = .black
        
        passwordCheckLine.backgroundColor = CFColor.Bg.gray04.cgColor
        passwordCheckTextField.layer.addSublayer(passwordCheckLine)
    }
    
    override func configureConstraints() {
        passwordTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(167)
            make.leading.equalToSuperview().inset(16)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTitle.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        passwordCheckTitle.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(32)
            make.leading.equalToSuperview().inset(16)
        }
        passwordCheckTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordCheckTitle.snp.bottom).offset(12)
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
        
        passwordLine.frame = CGRect(
            x: 0,
            y: passwordTextField.frame.size.height - 1,
            width: passwordTextField.frame.size.width,
            height: 1
        )
        
        passwordCheckLine.frame = CGRect(
            x: 0,
            y: passwordCheckTextField.frame.size.height - 1,
            width: passwordCheckTextField.frame.size.width,
            height: 1
        )
    }
}
