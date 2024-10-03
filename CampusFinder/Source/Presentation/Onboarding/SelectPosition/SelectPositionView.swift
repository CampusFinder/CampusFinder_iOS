//
//  SelectPositionView.swift
//  CampusFinder
//
//  Created by 강석호 on 8/11/24.
//

import UIKit
import SnapKit

final class SelectPositionView: BaseView {
    
    let introLabel = UILabel()
    let detailLabel = UILabel()
    let selectStudentView = CFSelectRoleView()
    let selectStudentButton = UIButton()
    let selectProfessorView = CFSelectRoleView()
    let selectProfessorButton = UIButton()
    
    override func configureHierarchy() {
        addSubview(introLabel)
        addSubview(detailLabel)
        addSubview(selectStudentView)
        addSubview(selectStudentButton)
        addSubview(selectProfessorView)
        addSubview(selectProfessorButton)
    }
    
    override func configureUI() {
        introLabel.text = "만나서 반가워요!\n캠파를 시작해볼까요?"
        introLabel.textColor = .black
        introLabel.font = .pretendard(size: 26, weight: .bold)
        introLabel.textAlignment = .center
        introLabel.numberOfLines = 2
        
        detailLabel.text = "함께하시는 분의 [직위]를 알려주세요"
        detailLabel.textColor = CFColor.black03
        detailLabel.font = .pretendard(size: 16, weight: .medium)
        detailLabel.textAlignment = .center
        detailLabel.numberOfLines = 1
        
        selectStudentView.selectedRole = "학생"
        selectStudentView.configureUI()
        
        selectStudentButton.backgroundColor = .clear
        
        selectProfessorView.selectedRole = "교수"
        selectProfessorView.configureUI()
        
        selectProfessorButton.backgroundColor = .clear
    }
    
    override func configureConstraints() {
        introLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(190)
            make.centerX.equalToSuperview()
        }
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(introLabel.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
        }
        selectStudentView.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(110)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(150)
        }
        selectStudentButton.snp.makeConstraints { make in
            make.edges.equalTo(selectStudentView)
        }
        selectProfessorView.snp.makeConstraints { make in
            make.top.equalTo(selectStudentView.snp.bottom).offset(14)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(150)
        }
        selectProfessorButton.snp.makeConstraints { make in
            make.edges.equalTo(selectProfessorView)
        }
    }
}
