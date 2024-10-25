//
//  DetailCampusView.swift
//  CampusFinder
//
//  Created by 강석호 on 8/30/24.
//

import UIKit
import SnapKit

class DetailPortfolioView: UIView {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let imageView = UIImageView()
    let pageControl = UIPageControl()
    let categoryView = UIView()
    let categoryLabel = UILabel()
    let titleLabel = UILabel()
    let userImage = UIImageView()
    let userName = UILabel()
    let firstCrossLine = CFLine.lightGrayLine()
    let secondCrossLine = CFLine.lightGrayLine()
    let isNearCampusTitle = UILabel()
    let isNearCampus = UILabel()
    let questMethodTitle = UILabel()
    let questMethod = UILabel()
    let thirdCrossLine = CFLine.lightGrayLine()
    let questDetailTitle = UILabel()
    let questDetail = UILabel()
    let chattingView = UIView()
    let chattingButton = CFButton.primaryButton(title: "채팅하기")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imageView)
        contentView.addSubview(pageControl)
        contentView.addSubview(categoryView)
        categoryView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(userImage)
        contentView.addSubview(userName)
        contentView.addSubview(firstCrossLine)
        contentView.addSubview(secondCrossLine)
        contentView.addSubview(isNearCampusTitle)
        contentView.addSubview(isNearCampus)
        contentView.addSubview(questMethodTitle)
        contentView.addSubview(questMethod)
        contentView.addSubview(thirdCrossLine)
        contentView.addSubview(questDetailTitle)
        contentView.addSubview(questDetail)
        
        addSubview(chattingView)
        chattingView.addSubview(chattingButton)
        
        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        scrollView.showsVerticalScrollIndicator = false
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        
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
        
        userName.font = UIFont(name: "Pretendard-Regular", size: 13)
        userName.textColor = .black
        
        isNearCampusTitle.text = "학교 근처 거주 여부"
        isNearCampusTitle.font = .pretendard(size: 18, weight: .bold)
        isNearCampusTitle.textColor = CFColor.black01
        
        isNearCampus.font = .pretendard(size: 16, weight: .medium)
        isNearCampus.textColor = CFColor.black02
        
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
        
        chattingView.backgroundColor = .white
        chattingView.clipsToBounds = true
        chattingView.layer.cornerRadius = 10
        chattingView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView)
            make.height.equalTo(330)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(imageView)
            make.centerX.equalTo(imageView)
        }
        
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.equalTo(contentView).inset(20)
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
        
        secondCrossLine.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        isNearCampusTitle.snp.makeConstraints { make in
            make.top.equalTo(secondCrossLine.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        isNearCampus.snp.makeConstraints { make in
            make.top.equalTo(isNearCampusTitle.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        questMethodTitle.snp.makeConstraints { make in
            make.top.equalTo(isNearCampus.snp.bottom).offset(16)
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
            make.bottom.equalTo(contentView.snp.bottom).inset(20)
        }
        
        chattingView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(114)
        }
        
        chattingButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(53)
        }
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 114, right: 0)
    }
    
    func updateLayoutBasedOnImageAvailability(_ hasImage: Bool) {
        imageView.isHidden = !hasImage
        pageControl.isHidden = !hasImage
        
        if hasImage {
            categoryView.snp.remakeConstraints { make in
                make.top.equalTo(imageView.snp.bottom).offset(20)
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
    }
}
