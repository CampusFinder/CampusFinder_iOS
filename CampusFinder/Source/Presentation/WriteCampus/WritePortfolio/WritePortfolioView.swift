//
//  WritePortfolioView.swift
//  CampusFinder
//
//  Created by 강석호 on 9/6/24.
//

import UIKit
import SnapKit

class WritePortfolioView: BaseView, UITextViewDelegate {
    
    let containerView = UIView()
    let scrollView = UIScrollView()
    
    let serviceLabel = UILabel()
    let serviceView = CFSelectView()
    let serviceButton = UIButton()
    let titleLabel = UILabel()
    let titleTextField = UITextField()
    let questMethodLabel = UILabel()
    let questStackView = UIStackView()
    let faceToFaceButton = CFButton.unselectedButton(title: "대면")
    let nonFaceToFaceButton = CFButton.unselectedButton(title: "비대면")
    let dontCareButton = CFButton.unselectedButton(title: "상관없음")
    let nearSchoolLabel = UILabel()
    let nearSchoolStackView = UIStackView()
    let residenceButton = CFButton.unselectedButton(title: "거주중 입니다")
    let noResidenceButton = CFButton.unselectedButton(title: "거주중이 아닙니다")
    let questDetailLabel = UILabel()
    let questDetailTextView = UITextView()
    
    override func configureHierarchy() {
        addSubview(containerView)
        containerView.addSubview(scrollView)
        
        scrollView.addSubview(serviceLabel)
        scrollView.addSubview(serviceView)
        scrollView.addSubview(serviceButton)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(titleTextField)
        scrollView.addSubview(questMethodLabel)
        scrollView.addSubview(questStackView)
        questStackView.addArrangedSubview(faceToFaceButton)
        questStackView.addArrangedSubview(nonFaceToFaceButton)
        questStackView.addArrangedSubview(dontCareButton)
        scrollView.addSubview(nearSchoolLabel)
        scrollView.addSubview(nearSchoolStackView)
        nearSchoolStackView.addArrangedSubview(residenceButton)
        nearSchoolStackView.addArrangedSubview(noResidenceButton)
        scrollView.addSubview(questDetailLabel)
        scrollView.addSubview(questDetailTextView)
        
        questDetailTextView.delegate = self
    }
    
    override func configureUI() {
        serviceLabel.text = "서비스"
        serviceLabel.font = .pretendard(size: 18, weight: .semibold)
        serviceLabel.textColor = CFColor.black01
        
        serviceButton.backgroundColor = .clear
        
        titleLabel.text = "제목"
        titleLabel.font = .pretendard(size: 18, weight: .semibold)
        titleLabel.textColor = CFColor.black01
        
        titleTextField.backgroundColor = .white
        titleTextField.layer.cornerRadius = 10
        titleTextField.addLeftPadding()
        titleTextField.placeholder = "최대 30자 입력가능"
        
        questMethodLabel.text = "진행방식"
        questMethodLabel.font = .pretendard(size: 18, weight: .semibold)
        questMethodLabel.textColor = CFColor.black01
        
        questStackView.axis = .horizontal
        questStackView.spacing = 10
        questStackView.alignment = .center
        questStackView.distribution = .fillEqually
        
        nearSchoolLabel.text = "학교 근처 거주 여부"
        nearSchoolLabel.font = .pretendard(size: 18, weight: .semibold)
        nearSchoolLabel.textColor = CFColor.black01
        
        nearSchoolStackView.axis = .horizontal
        nearSchoolStackView.spacing = 10
        nearSchoolStackView.alignment = .center
        nearSchoolStackView.distribution = .fillEqually
        
        questDetailLabel.text = "의뢰내용"
        questDetailLabel.font = .pretendard(size: 18, weight: .semibold)
        questDetailLabel.textColor = CFColor.black01
        
        questDetailTextView.layer.cornerRadius = 10
    }
    
    override func configureConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
            make.width.equalTo(containerView.snp.width)
        }
        
        serviceLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).inset(14)
            make.leading.equalTo(containerView).inset(16)
        }
        
        serviceView.snp.makeConstraints { make in
            make.top.equalTo(serviceLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(16)
            make.height.equalTo(45)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(serviceView.snp.bottom).offset(28)
            make.leading.equalTo(containerView).inset(16)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(16)
            make.height.equalTo(45)
        }
        
        questMethodLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(28)
            make.leading.equalTo(containerView).inset(16)
        }
        
        questStackView.snp.makeConstraints { make in
            make.top.equalTo(questMethodLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(16)
            make.height.equalTo(45)
        }
        
        faceToFaceButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        
        nonFaceToFaceButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        
        dontCareButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        
        nearSchoolLabel.snp.makeConstraints { make in
            make.top.equalTo(questStackView.snp.bottom).offset(28)
            make.leading.equalTo(containerView).inset(16)
        }
        
        nearSchoolStackView.snp.makeConstraints { make in
            make.top.equalTo(nearSchoolLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(16)
            make.height.equalTo(45)
        }
        
        residenceButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        
        noResidenceButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        
        questDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(nearSchoolStackView.snp.bottom).offset(28)
            make.leading.equalTo(containerView).inset(16)
        }
        
        questDetailTextView.snp.makeConstraints { make in
            make.top.equalTo(questDetailLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(16)
            make.height.equalTo(260)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let maxHeight: CGFloat = 260 // 최대 높이 설정
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        if estimatedSize.height <= maxHeight {
            textView.snp.updateConstraints { make in
                make.height.equalTo(estimatedSize.height) // 높이 업데이트
            }
        }
    }
}
