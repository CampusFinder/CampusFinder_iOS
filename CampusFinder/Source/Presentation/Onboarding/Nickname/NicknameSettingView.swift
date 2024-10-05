//
//  NicknameSettingView.swift
//  CampusFinder
//
//  Created by 강석호 on 10/3/24.
//

import UIKit
import SnapKit

class NicknameSettingView: BaseView {
    let nicknameTitle = UILabel()
    let nicknameDescription = UILabel()
    let nicknameTextField = UITextField()
    let nicknameLine = CALayer()
    let comfirmButton = UIButton()
    let nextButton = CFButton.grayButton(title: "다음")
    
    override func configureHierarchy() {
        addSubview(nicknameTitle)
        addSubview(nicknameTextField)
        addSubview(nicknameDescription)
        addSubview(nextButton)
    }
    
    override func configureUI() {
        nicknameTitle.font = .pretendard(size: 18, weight: .semibold)
        nicknameTitle.text = "닉네임"
        nicknameTitle.textColor = .black
        
        nicknameTextField.backgroundColor = .clear
        nicknameTextField.placeholder = "닉네임을 입력하세요"
        nicknameTextField.textAlignment = .left
        nicknameTextField.textColor = .black
        
        comfirmButton.setTitle("확인", for: .normal)
        comfirmButton.setTitleColor(CFColor.black02, for: .normal)
        comfirmButton.titleLabel?.font = .pretendard(size: 16, weight: .medium)
        
        nicknameTextField.rightView = comfirmButton
        nicknameTextField.rightViewMode = .always
        
        nicknameLine.backgroundColor = CFColor.Bg.gray04.cgColor
        nicknameTextField.layer.addSublayer(nicknameLine)
        
        nicknameDescription.text = "한글, 영문, 숫자 포함 8자 이내 (특수문자 불가능)"
        nicknameDescription.font = .pretendard(size: 12, weight: .regular)
        nicknameDescription.textColor = CFColor.black04
    }
    
    override func configureConstraints() {
        nicknameTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(167)
            make.leading.equalToSuperview().inset(16)
        }
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameTitle.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        nicknameDescription.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(9)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(60)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nicknameLine.frame = CGRect(
            x: 0,
            y: nicknameTextField.frame.size.height - 1,
            width: nicknameTextField.frame.size.width,
            height: 1
        )
    }
}
