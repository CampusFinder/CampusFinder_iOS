//
//  CFSelectRoleView.swift
//  CampusFinder
//
//  Created by 강석호 on 10/3/24.
//

import UIKit
import SnapKit

class CFSelectRoleView: BaseView {
    
    let roleImageView = UIImageView()
    let roleLabel = UILabel()
    let startLabel = UILabel()
    
    var selectedRole: String?
    
    override func configureHierarchy() {
        addSubview(roleImageView)
        addSubview(roleLabel)
        addSubview(startLabel)
    }
    
    override func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        
        if selectedRole == "학생" {
            roleImageView.image = UIImage(named: "student")
        } else {
            roleImageView.image = UIImage(named: "professor")
        }
        roleImageView.contentMode = .scaleAspectFit
        
        roleLabel.text = selectedRole
        roleLabel.font = .pretendard(size: 20, weight: .bold)
        roleLabel.textColor = .black
        
        startLabel.text = "시작하기"
        startLabel.font = .pretendard(size: 16, weight: .medium)
        startLabel.textColor = CFColor.black03
    }
    
    override func configureConstraints() {
        roleImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(23)
            make.width.equalTo(27)
            make.height.equalTo(25)
        }
        roleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(roleImageView.snp.trailing).offset(12)
        }
        startLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(roleLabel.snp.trailing).offset(4)
        }
    }
}
