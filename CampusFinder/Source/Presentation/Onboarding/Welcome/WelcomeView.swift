//
//  WelcomeView.swift
//  CampusFinder
//
//  Created by 강석호 on 10/6/24.
//

import UIKit
import SnapKit

class WelcomeView: BaseView {
    
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    let startButton = CFButton.primaryButton(title: "시작하기")
    
    override func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(detailLabel)
        addSubview(startButton)
    }
    
    override func configureUI() {
        titleLabel.text = "캠퍼스 파인더\n활동 준비가\n완료되었습니다!"
        titleLabel.textColor = .black
        titleLabel.font = .pretendard(size: 36, weight: .bold)
        titleLabel.numberOfLines = 0
        
        detailLabel.text = "의뢰찾기 서비스를 시작해요!"
        detailLabel.textColor = .black
        detailLabel.font = .pretendard(size: 18, weight: .medium)
    }
    
    override func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(210)
            make.leading.equalToSuperview().inset(29)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(29)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(60)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
    }
}
