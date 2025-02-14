//
//  ProfileView.swift
//  CampusFinder
//
//  Created by 이빈 on 12/5/24.
//

import UIKit
import SnapKit
import Then

final class ProfileView: BaseView {
    var userInfoView = UIView()
    var profileImageView = UIImageView()
    var userNameLabel = UILabel()
    
    let profileMenuTableView = UITableView()
    
    override func configureUI() {
        userInfoView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 12
            $0.layer.borderColor = UIColor.systemGray6.cgColor
            $0.layer.borderWidth = 1
            $0.isUserInteractionEnabled = true
        }
        
        profileImageView.do {
            $0.backgroundColor = .gray
            $0.layer.cornerRadius = 32
            $0.clipsToBounds = true
        }
        
        userNameLabel.do {
            $0.text = "Vicky"
            $0.font = .pretendard(size: 20, weight: .semibold)
        }
        
        profileMenuTableView.do {
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 8
            $0.separatorStyle = .none
            $0.register(ProfileMenuTableViewCell.self, forCellReuseIdentifier: ProfileMenuTableViewCell.identifier)
            $0.isScrollEnabled = false
        }
    }
    
    override func configureHierarchy() {
        [profileImageView, userNameLabel].forEach {
            userInfoView.addSubview($0)
        }
        
        addSubview(userInfoView)
        addSubview(profileMenuTableView)
    }
    
    override func configureConstraints() {
        userInfoView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(120)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(96)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(64)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
        }
        
        profileMenuTableView.snp.makeConstraints {
            $0.top.equalTo(userInfoView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
}
