//
//  WriteRequestView.swift
//  CampusFinder
//
//  Created by 강석호 on 9/5/24.
//

import UIKit
import SnapKit

class WriteRequestView: BaseView, UITextViewDelegate {
    
    let containerView = UIView()
    let scrollView = UIScrollView()
    
    let serviceLabel = UILabel()
    let serviceView = CFSelectView()
    let serviceButton = UIButton()
    let titleLabel = UILabel()
    let titleTextField = UITextField()
    let priceLabel = UILabel()
    let priceView = CFPriceView()
    let discussionButton = UIButton()
    let discusstionLabel = UILabel()
    let deadlineLabel = UILabel()
    let deadlineView = CFSelectView()
    let deadlineButton = UIButton()
    let rightNowButton = UIButton()
    let rightNowLabel = UILabel()
    let requestMethodLabel = UILabel()
    let requestStackView = UIStackView()
    let faceToFaceButton = CFButton.unselectedButton(title: "대면")
    let nonFaceToFaceButton = CFButton.unselectedButton(title: "비대면")
    let dontCareButton = CFButton.unselectedButton(title: "상관없음")
    let requestDetailLabel = UILabel()
    let requestDetailTextView = UITextView()
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
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(priceView)
        scrollView.addSubview(discussionButton)
        scrollView.addSubview(discusstionLabel)
        scrollView.addSubview(deadlineLabel)
        scrollView.addSubview(deadlineView)
        deadlineView.addSubview(deadlineButton)
        scrollView.addSubview(rightNowButton)
        scrollView.addSubview(rightNowLabel)
        scrollView.addSubview(requestMethodLabel)
        scrollView.addSubview(requestStackView)
        requestStackView.addArrangedSubview(faceToFaceButton)
        requestStackView.addArrangedSubview(nonFaceToFaceButton)
        requestStackView.addArrangedSubview(dontCareButton)
        scrollView.addSubview(requestDetailLabel)
        scrollView.addSubview(requestDetailTextView)
        scrollView.addSubview(addPhotoLabel)
        scrollView.addSubview(addPhotoView)
        
        requestDetailTextView.addSubview(placeholderLabel)
        requestDetailTextView.delegate = self
        
        addSubview(completeView)
        completeView.addSubview(completeButton)
        
        placeholderLabel.isHidden = !requestDetailTextView.text.isEmpty
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
        
        priceLabel.font = .pretendard(size: 18, weight: .semibold)
        priceLabel.textColor = CFColor.black01
        priceLabel.attributedText = createAttributedText(fullText: "제시금액*", coloredText: "*")
        
        discussionButton.setImage(UIImage(named: "toggle"), for: .normal)
        discussionButton.imageView?.contentMode = .scaleAspectFit
        
        discusstionLabel.font = .pretendard(size: 14, weight: .regular)
        discusstionLabel.textColor = CFColor.black01
        discusstionLabel.text = "협의가능"
        
        deadlineLabel.font = .pretendard(size: 18, weight: .semibold)
        deadlineLabel.textColor = CFColor.black01
        deadlineLabel.attributedText = createAttributedText(fullText: "마감기한*", coloredText: "*")
        
        deadlineButton.backgroundColor = .clear
        
        rightNowButton.setImage(UIImage(named: "toggle"), for: .normal)
        rightNowButton.imageView?.contentMode = .scaleAspectFit
        
        rightNowLabel.font = .pretendard(size: 14, weight: .regular)
        rightNowLabel.textColor = CFColor.black01
        rightNowLabel.text = "당장구함"
        
        requestMethodLabel.font = .pretendard(size: 18, weight: .semibold)
        requestMethodLabel.textColor = CFColor.black01
        requestMethodLabel.attributedText = createAttributedText(fullText: "진행방식*", coloredText: "*")
        
        requestStackView.axis = .horizontal
        requestStackView.spacing = 10
        requestStackView.alignment = .center
        requestStackView.distribution = .fillEqually
        
        requestDetailLabel.font = .pretendard(size: 18, weight: .semibold)
        requestDetailLabel.textColor = CFColor.black01
        requestDetailLabel.attributedText = createAttributedText(fullText: "의뢰내용*", coloredText: "*")
        
        requestDetailTextView.layer.cornerRadius = 10
        requestDetailTextView.font = .pretendard(size: 16, weight: .medium)
        requestDetailTextView.textColor = CFColor.black01
        
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
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(28)
            make.leading.equalTo(containerView).inset(16)
        }
        
        priceView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(16)
            make.height.equalTo(45)
        }
        
        discussionButton.snp.makeConstraints { make in
            make.top.equalTo(priceView.snp.bottom).offset(10)
            make.leading.equalTo(containerView).inset(16)
            make.size.equalTo(24)
        }
        
        discusstionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(discussionButton)
            make.leading.equalTo(discussionButton.snp.trailing).offset(5)
        }
        
        deadlineLabel.snp.makeConstraints { make in
            make.top.equalTo(discusstionLabel.snp.bottom).offset(28)
            make.leading.equalTo(containerView).inset(16)
        }
        
        deadlineView.snp.makeConstraints { make in
            make.top.equalTo(deadlineLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(16)
            make.height.equalTo(45)
        }
        
        deadlineButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        rightNowButton.snp.makeConstraints { make in
            make.top.equalTo(deadlineView.snp.bottom).offset(10)
            make.leading.equalTo(containerView).inset(16)
            make.size.equalTo(24)
        }
        
        rightNowLabel.snp.makeConstraints { make in
            make.centerY.equalTo(rightNowButton)
            make.leading.equalTo(rightNowButton.snp.trailing).offset(5)
        }
        
        requestMethodLabel.snp.makeConstraints { make in
            make.top.equalTo(rightNowLabel.snp.bottom).offset(28)
            make.leading.equalTo(containerView).inset(16)
        }
        
        requestStackView.snp.makeConstraints { make in
            make.top.equalTo(requestMethodLabel.snp.bottom).offset(10)
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
        
        requestDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(requestStackView.snp.bottom).offset(28)
            make.leading.equalTo(containerView).inset(16)
        }
        
        requestDetailTextView.snp.makeConstraints { make in
            make.top.equalTo(requestDetailLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(16)
            textViewHeightConstraint = make.height.equalTo(initialHeight).constraint
        }
        
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalTo(requestDetailTextView).inset(14)
            make.leading.equalTo(requestDetailTextView).inset(15)
        }
        
        addPhotoLabel.snp.makeConstraints { make in
            make.top.equalTo(requestDetailTextView.snp.bottom).offset(28)
            make.leading.equalTo(containerView).inset(16)
        }
        
        addPhotoView.snp.makeConstraints { make in
            make.top.equalTo(addPhotoLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(16) // trailing 제약 추가
            make.bottom.equalTo(scrollView.snp.bottom).inset(100)
            make.height.equalTo(80) // size 대신 height만 지정
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
