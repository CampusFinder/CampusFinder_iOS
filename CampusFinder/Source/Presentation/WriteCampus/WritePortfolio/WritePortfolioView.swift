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
    let nonResidenceButton = CFButton.unselectedButton(title: "거주중이 아닙니다")
    let questDetailLabel = UILabel()
    let questDetailTextView = UITextView()
    let addPhotoLabel = UILabel()
    let addPhotoView = CFAddPhotoView()
    let completeView = UIView()
    let completeButton = CFButton.primaryButton(title: "등록하기")
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "의뢰에 대한 상세내용을 넣어주세요"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    // 기본 높이값 설정
    var textViewHeightConstraint: Constraint?
    let initialHeight: CGFloat = 260
    let minHeight: CGFloat = 260
    let maxHeight: CGFloat = 400
    
    override func configureHierarchy() {
        addSubview(containerView)
        containerView.addSubview(scrollView)
        
        scrollView.addSubview(serviceLabel)
        scrollView.addSubview(serviceView)
        serviceView.addSubview(serviceButton)
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
        nearSchoolStackView.addArrangedSubview(nonResidenceButton)
        scrollView.addSubview(questDetailLabel)
        scrollView.addSubview(questDetailTextView)
        scrollView.addSubview(addPhotoLabel)
        scrollView.addSubview(addPhotoView)
        
        questDetailTextView.addSubview(placeholderLabel)
        questDetailTextView.delegate = self
        
        addSubview(completeView)
        completeView.addSubview(completeButton)
        
        placeholderLabel.isHidden = !questDetailTextView.text.isEmpty
    }
    
    override func configureUI() {
        serviceLabel.font = .pretendard(size: 18, weight: .semibold)
        serviceLabel.textColor = CFColor.black01
        serviceLabel.attributedText = createAttributedText(fullText: "서비스*", coloredText: "*")
        
        serviceButton.backgroundColor = .clear
        
        titleLabel.font = .pretendard(size: 18, weight: .semibold)
        titleLabel.textColor = CFColor.black01
        titleLabel.attributedText = createAttributedText(fullText: "제목*", coloredText: "*")
        
        titleTextField.backgroundColor = .white
        titleTextField.layer.cornerRadius = 10
        titleTextField.addLeftPadding()
        titleTextField.placeholder = "최대 30자 입력가능"
        
        questMethodLabel.font = .pretendard(size: 18, weight: .semibold)
        questMethodLabel.textColor = CFColor.black01
        questMethodLabel.attributedText = createAttributedText(fullText: "진행방식*", coloredText: "*")
        
        questStackView.axis = .horizontal
        questStackView.spacing = 10
        questStackView.alignment = .center
        questStackView.distribution = .fillEqually
        
        nearSchoolLabel.font = .pretendard(size: 18, weight: .semibold)
        nearSchoolLabel.textColor = CFColor.black01
        nearSchoolLabel.attributedText = createAttributedText(fullText: "학교 근처 거주 여부*", coloredText: "*")
        
        nearSchoolStackView.axis = .horizontal
        nearSchoolStackView.spacing = 10
        nearSchoolStackView.alignment = .center
        nearSchoolStackView.distribution = .fillEqually
        
        questDetailLabel.font = .pretendard(size: 18, weight: .semibold)
        questDetailLabel.textColor = CFColor.black01
        questDetailLabel.attributedText = createAttributedText(fullText: "의뢰내용*", coloredText: "*")
        
        questDetailTextView.layer.cornerRadius = 10
        questDetailTextView.font = .pretendard(size: 16, weight: .medium)
        questDetailTextView.textColor = CFColor.black01
        
        addPhotoLabel.text = "참고사진"
        addPhotoLabel.font = .pretendard(size: 18, weight: .semibold)
        addPhotoLabel.textColor = CFColor.black01
        
        completeView.backgroundColor = .white
        completeView.clipsToBounds = true
        completeView.layer.cornerRadius = 10
        completeView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
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
        
        serviceButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        
        nonResidenceButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        
        questDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(nearSchoolStackView.snp.bottom).offset(28)
            make.leading.equalTo(containerView).inset(16)
        }
        
        questDetailTextView.snp.makeConstraints { make in
            make.top.equalTo(questDetailLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(16)
            textViewHeightConstraint = make.height.equalTo(initialHeight).constraint
        }
        
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalTo(questDetailTextView).inset(14)
            make.leading.equalTo(questDetailTextView).inset(15)
        }
        
        addPhotoLabel.snp.makeConstraints { make in
            make.top.equalTo(questDetailTextView.snp.bottom).offset(28)
            make.leading.equalTo(containerView).inset(16)
        }
        
        addPhotoView.snp.makeConstraints { make in
            make.top.equalTo(addPhotoLabel.snp.bottom).offset(10)
            make.leading.equalTo(containerView).inset(16)
            make.bottom.equalTo(scrollView.snp.bottom).inset(100)
            make.size.equalTo(80)
        }
        
        completeView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(114)
        }
        
        completeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(53)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        if estimatedSize.height >= minHeight && estimatedSize.height <= maxHeight {
            textView.snp.updateConstraints { make in
                make.height.equalTo(estimatedSize.height)
            }
        } else if estimatedSize.height > maxHeight {
            textView.snp.updateConstraints { make in
                make.height.equalTo(maxHeight)
            }
        } else if estimatedSize.height < minHeight {
            textView.snp.updateConstraints { make in
                make.height.equalTo(minHeight)
            }
        }
        
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
