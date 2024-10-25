//
//  DetailRequestView.swift
//  CampusFinder
//
//  Created by 강석호 on 10/20/24.
//

import UIKit
import SnapKit

class DetailRequestView: BaseView {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let categoryView = UIView()
    let categoryLabel = UILabel()
    let titleLabel = UILabel()
    let userImage = UIImageView()
    let userName = UILabel()
    
    let firstCrossLine = CFLine.lightGrayLine()
    let priceTitle = UILabel()
    let priceLabel = UILabel()
    let negotiableLabel = UILabel()
    let urgentLabel = UILabel()
    
    let secondCrossLine = CFLine.lightGrayLine()
    let deadLineTitle = UILabel()
    let deadLine = UILabel()
    let questMethodTitle = UILabel()
    let questMethod = UILabel()
    
    let thirdCrossLine = CFLine.lightGrayLine()
    let questDetailTitle = UILabel()
    let questDetail = UILabel()
    
    let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let pageControl = UIPageControl()
    let chattingButton = CFButton.primaryButton(title: "채팅하기")
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [imageCollectionView, pageControl, categoryView, titleLabel, userImage, userName,
         firstCrossLine, priceTitle, priceLabel, negotiableLabel, urgentLabel,
         secondCrossLine, deadLineTitle, deadLine, questMethodTitle, questMethod,
         thirdCrossLine, questDetailTitle, questDetail].forEach {
            contentView.addSubview($0)
        }
        
        categoryView.addSubview(categoryLabel)
        addSubview(chattingButton)
    }
    
    override func configureUI() {
        // 기존 UI 설정 유지
        categoryView.backgroundColor = CFColor.Bg.gray03
        categoryView.layer.cornerRadius = 10
        
        categoryLabel.font = .pretendard(size: 14, weight: .medium)
        categoryLabel.textColor = CFColor.Primary.blue01
        categoryLabel.textAlignment = .center
        
        titleLabel.font = .pretendard(size: 22, weight: .semibold)
        titleLabel.textColor = CFColor.black01
        titleLabel.numberOfLines = 2
        
        userImage.backgroundColor = .gray
        userImage.layer.cornerRadius = 19
        
        userName.font = .pretendard(size: 13, weight: .regular)
        userName.textColor = .black
        
        // 새로운 UI 요소 설정
        priceTitle.text = "제시금액"
        priceTitle.font = .pretendard(size: 18, weight: .bold)
        priceTitle.textColor = CFColor.black01
        
        priceLabel.font = .pretendard(size: 18, weight: .semibold)
        priceLabel.textColor = CFColor.Primary.blue01
        
        negotiableLabel.font = .pretendard(size: 14, weight: .medium)
        negotiableLabel.textColor = CFColor.black03
        
        urgentLabel.text = "급구"
        urgentLabel.font = .pretendard(size: 14, weight: .medium)
        urgentLabel.textColor = UIColor(hexCode: "FA5252")
        urgentLabel.isHidden = true
        
        // 기존 UI 설정 계속
        deadLineTitle.text = "마감기한"
        deadLineTitle.font = .pretendard(size: 18, weight: .bold)
        deadLineTitle.textColor = CFColor.black01
        
        deadLine.font = .pretendard(size: 16, weight: .medium)
        deadLine.textColor = CFColor.black02
        
        questMethodTitle.text = "진행방식"
        questMethodTitle.font = .pretendard(size: 18, weight: .bold)
        questMethodTitle.textColor = CFColor.black01
        
        questMethod.font = .pretendard(size: 16, weight: .medium)
        questMethod.textColor = CFColor.black02
        
        questDetailTitle.text = "의뢰내용"
        questDetailTitle.font = .pretendard(size: 18, weight: .bold)
        questDetailTitle.textColor = CFColor.black01
        
        questDetail.font = .pretendard(size: 16, weight: .medium)
        questDetail.textColor = CFColor.black02
        questDetail.numberOfLines = 0
        
        pageControl.currentPageIndicatorTintColor = CFColor.Primary.blue01
        pageControl.pageIndicatorTintColor = .systemGray4
    }
    
    override func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(200)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(imageCollectionView.snp.bottom).offset(-10)
            make.centerX.equalToSuperview()
        }
        
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.bottom).offset(20)
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
        
        firstCrossLine.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
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
        
        priceTitle.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(priceTitle.snp.bottom).offset(6)
            make.leading.equalToSuperview().inset(16)
        }
        
        negotiableLabel.snp.makeConstraints { make in
            make.centerY.equalTo(priceLabel)
            make.leading.equalTo(priceLabel.snp.trailing).offset(8)
        }
        
        urgentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(priceLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        
        secondCrossLine.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(16)
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
            make.bottom.equalTo(contentView).inset(100)
        }
        
        chattingButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(45)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(53)
        }
    }
    
    func updateImageCollectionView(hasImage: Bool) {
        imageCollectionView.isHidden = !hasImage
        pageControl.isHidden = !hasImage
    }
    
    func updateLayoutBasedOnImageAvailability(_ hasImage: Bool) {
        imageCollectionView.isHidden = !hasImage
        pageControl.isHidden = !hasImage
        
        if hasImage {
            categoryView.snp.remakeConstraints { make in
                make.top.equalTo(imageCollectionView.snp.bottom).offset(20)
                make.leading.equalTo(contentView).inset(20)
                make.height.equalTo(30)
                make.width.equalTo(60)
            }
        } else {
            categoryView.snp.remakeConstraints { make in
                make.top.equalTo(contentView).offset(20)
                make.leading.equalTo(contentView).inset(20)
                make.height.equalTo(30)
                make.width.equalTo(60)
            }
        }
        
        // 레이아웃 변경사항 즉시 적용
        contentView.layoutIfNeeded()
    }
}
