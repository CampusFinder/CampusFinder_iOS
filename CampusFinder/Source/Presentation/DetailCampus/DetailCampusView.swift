//
//  DetailCampusView.swift
//  CampusFinder
//
//  Created by 강석호 on 8/30/24.
//

import UIKit
import SnapKit

class DetailCampusView: BaseView {
    
    let categoryView = UIView()
    let categoryLabel = UILabel()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    let userImage = UIImageView()
    let userName = UILabel()
    let firstCrossLine = CFLine.lightGrayLine()
    let secondCrossLine = CFLine.lightGrayLine()
    let deadLineTitle = UILabel()
    let deadLine = UILabel()
    let questMethodTitle = UILabel()
    let questMethod = UILabel()
    let thirdCrossLine = CFLine.lightGrayLine()
    let questDetailTitle = UILabel()
    let questDetail = UILabel()
    let chattingButton = CFButton.primaryButton(title: "채팅하기")
    
    override func configureHierarchy() {
        addSubview(categoryView)
        categoryView.addSubview(categoryLabel)
        addSubview(titleLabel)
        addSubview(userImage)
        addSubview(userName)
        addSubview(priceLabel)
        addSubview(firstCrossLine)
        addSubview(secondCrossLine)
        addSubview(deadLineTitle)
        addSubview(deadLine)
        addSubview(questMethodTitle)
        addSubview(questMethod)
        addSubview(thirdCrossLine)
        addSubview(questDetailTitle)
        addSubview(questDetail)
        addSubview(chattingButton)
    }
    
    override func configureUI() {
        categoryView.backgroundColor = CFColor.Bg.gray03
        categoryView.layer.cornerRadius = 10
        
        categoryLabel.text = "디자인"
        categoryLabel.font = .pretendard(size: 14, weight: .medium)
        categoryLabel.textColor = CFColor.Primary.blue01
        categoryLabel.textAlignment = .center
        
        titleLabel.text = "지금 학교에서 ppt 화면 제작해주실 분 구해요~!"
        titleLabel.font = .pretendard(size: 22, weight: .semibold)
        titleLabel.textColor = CFColor.black01
        titleLabel.numberOfLines = 2
        
//        userImage.image = UIImage(systemName: "person.fill")
//        userImage.contentMode = .scaleAspectFit
        userImage.backgroundColor = .gray
        userImage.layer.cornerRadius = 19
        
        userName.text = "화양리 보안관"
        userName.font = UIFont(name: "Pretendard-Regular", size: 13)
        userName.textColor = .black
        
        priceLabel.text = "제시금액 100000원"
        priceLabel.font = .pretendard(size: 14, weight: .semibold)
        priceLabel.numberOfLines = 4
        
        deadLineTitle.text = "마감기한"
        deadLineTitle.font = .pretendard(size: 18, weight: .bold)
        deadLineTitle.textColor = CFColor.black01
        
        deadLine.text = "24.08.17"
        deadLine.font = .pretendard(size: 16, weight: .medium)
        deadLine.textColor = CFColor.black02
        
        questMethodTitle.text = "진행방식"
        questMethodTitle.font = .pretendard(size: 18, weight: .bold)
        questMethodTitle.textColor = CFColor.black01
        
        questMethod.text = "대면"
        questMethod.font = .pretendard(size: 16, weight: .medium)
        questMethod.textColor = CFColor.black02
        
        questDetailTitle.text = "의뢰내용"
        questDetailTitle.font = .pretendard(size: 18, weight: .bold)
        questDetailTitle.textColor = CFColor.black01
        
        questDetail.text = "학술정보원에서 만나서 ppt 제작해주실 분 구합니다! 빠를수록 좋아요"
        questDetail.font = .pretendard(size: 16, weight: .medium)
        questDetail.textColor = CFColor.black02
        questDetail.numberOfLines = 0
    }
    
    override func configureConstraints() {
        categoryView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(125)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
        categoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryView.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        firstCrossLine.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        userImage.snp.makeConstraints { make in
            make.top.equalTo(firstCrossLine.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.size.equalTo(38)
        }
        userName.snp.makeConstraints { make in
            make.centerY.equalTo(userImage)
            make.leading.equalTo(userImage.snp.trailing).offset(8)
        }
        secondCrossLine.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        deadLineTitle.snp.makeConstraints { make in
            make.top.equalTo(secondCrossLine.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        deadLine.snp.makeConstraints { make in
            make.top.equalTo(deadLineTitle.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        questMethodTitle.snp.makeConstraints { make in
            make.top.equalTo(deadLine.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        questMethod.snp.makeConstraints { make in
            make.top.equalTo(questMethodTitle.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        thirdCrossLine.snp.makeConstraints { make in
            make.top.equalTo(questMethod.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        questDetailTitle.snp.makeConstraints { make in
            make.top.equalTo(thirdCrossLine.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        questDetail.snp.makeConstraints { make in
            make.top.equalTo(questDetailTitle.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        chattingButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(45)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(53)
        }
    }
}
