//
//  ProfessorView.swift
//  CampusFinder
//
//  Created by 강석호 on 8/30/24.
//

import UIKit

class ProfessorView: BaseView {
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    let stackView = UIStackView()
    
    override func configureHierarchy() {
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        addSubview(stackView)
    }
    
    override func configureUI() {
        
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        
        titleLabel.text = "교수님 의뢰공고"
        titleLabel.textColor = .black
        titleLabel.font = .pretendard(size: 20, weight: .bold)
        titleLabel.textAlignment = .left
        
        descriptionLabel.text = "교수 요청의뢰 찾아보기"
        descriptionLabel.textColor = CFColor.black03
        descriptionLabel.font = .pretendard(size: 16, weight: .medium)
        descriptionLabel.textAlignment = .left
    }
    
    override func configureConstraints() {
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}
