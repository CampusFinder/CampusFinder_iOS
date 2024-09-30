//
//  ChattingTableViewCell.swift
//  CampusFinder
//
//  Created by 강석호 on 9/29/24.
//

import UIKit
import SnapKit

final class ChattingTableViewCell: BaseTableViewCell {
    static let identifier = "ChattingTableViewCell"
    
    let profileImageView = UIImageView()
    let nicknameLabel = UILabel()
    let messageLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(messageLabel)
    }
    
    override func configureView() {
        profileImageView.image = UIImage(systemName: "figure.arms.open")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.backgroundColor = .lightGray
        profileImageView.layer.cornerRadius = 32
        
        nicknameLabel.text = "화양리 보안관"
        nicknameLabel.font = .pretendard(size: 18, weight: .bold)
        nicknameLabel.textColor = CFColor.black01
        nicknameLabel.numberOfLines = 1
        
        messageLabel.font = .pretendard(size: 16, weight: .medium)
        messageLabel.textColor = CFColor.black03
        messageLabel.numberOfLines = 1
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(64)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
            make.top.equalToSuperview().inset(24)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
            make.bottom.equalToSuperview().inset(24)
        }
    }
    
    func configure(with message: String) {
        messageLabel.text = message
    }
}

