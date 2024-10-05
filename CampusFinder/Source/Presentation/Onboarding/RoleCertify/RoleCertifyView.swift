//
//  RoleCertifyView.swift
//  CampusFinder
//
//  Created by 강석호 on 10/3/24.
//

import UIKit
import SnapKit

class RoleCertifyView: BaseView {
    let campusTitle = UILabel()
    let campusTextField = UITextField()
    let campusLine = CALayer()
    let emailTitle = UILabel()
    let emailTextField = UITextField()
    let emailLine = CALayer()
    let emailButton = UIButton()
    let certifyNumberTitle = UILabel()
    let certifyNumberTextField = UITextField()
    let certifyNumberLine = CALayer()
    let certifyNumberButton = UIButton()
    let nextButton = CFButton.grayButton(title: "다음")
    
    override func configureHierarchy() {
        addSubview(campusTitle)
        addSubview(campusTextField)
        addSubview(emailTitle)
        addSubview(emailTextField)
        addSubview(certifyNumberTitle)
        addSubview(certifyNumberTextField)
        addSubview(nextButton)
    }
    
    override func configureUI() {
        campusTitle.font = .pretendard(size: 18, weight: .semibold)
        campusTitle.text = "학교명"
        campusTitle.textColor = .black
        
        campusTextField.backgroundColor = .clear
        campusTextField.placeholder = "ex) 세종대학교"
        campusTextField.textAlignment = .left
        campusTextField.textColor = .black
        
        campusLine.backgroundColor = CFColor.Bg.gray04.cgColor
        campusTextField.layer.addSublayer(campusLine)
        
        emailTitle.font = .pretendard(size: 18, weight: .semibold)
        emailTitle.text = "학교 이메일"
        emailTitle.textColor = .black
        
        emailTextField.backgroundColor = .clear
        emailTextField.placeholder = "학교 이메일을 입력하세요"
        emailTextField.textAlignment = .left
        emailTextField.textColor = .black
        
        emailButton.setTitle("전송", for: .normal)
        emailButton.setTitleColor(CFColor.black02, for: .normal)
        emailButton.titleLabel?.font = .pretendard(size: 16, weight: .medium)

        emailTextField.rightView = emailButton
        emailTextField.rightViewMode = .always
        
        emailLine.backgroundColor = CFColor.Bg.gray04.cgColor
        emailTextField.layer.addSublayer(emailLine)
        
        certifyNumberTitle.font = .pretendard(size: 18, weight: .semibold)
        certifyNumberTitle.text = "인증번호 확인"
        certifyNumberTitle.textColor = .black
        
        certifyNumberTextField.backgroundColor = .clear
        certifyNumberTextField.placeholder = "인증번호를 입력하세요"
        certifyNumberTextField.textAlignment = .left
        certifyNumberTextField.textColor = .black
        
        certifyNumberButton.setTitle("확인", for: .normal)
        certifyNumberButton.setTitleColor(CFColor.black02, for: .normal)
        certifyNumberButton.titleLabel?.font = .pretendard(size: 16, weight: .medium)

        certifyNumberTextField.rightView = certifyNumberButton
        certifyNumberTextField.rightViewMode = .always
        
        certifyNumberLine.backgroundColor = CFColor.Bg.gray04.cgColor
        certifyNumberTextField.layer.addSublayer(certifyNumberLine)
    }
    
    override func configureConstraints() {
        campusTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(167)
            make.leading.equalToSuperview().inset(16)
        }
        campusTextField.snp.makeConstraints { make in
            make.top.equalTo(campusTitle.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        emailTitle.snp.makeConstraints { make in
            make.top.equalTo(campusTextField.snp.bottom).offset(32)
            make.leading.equalToSuperview().inset(16)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTitle.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        certifyNumberTitle.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(32)
            make.leading.equalToSuperview().inset(16)
        }
        certifyNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(certifyNumberTitle.snp.bottom).offset(12)
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
        
        campusLine.frame = CGRect(
            x: 0,
            y: campusTextField.frame.size.height - 1,
            width: campusTextField.frame.size.width,
            height: 1
        )
        
        emailLine.frame = CGRect(
            x: 0,
            y: emailTextField.frame.size.height - 1,
            width: emailTextField.frame.size.width,
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
