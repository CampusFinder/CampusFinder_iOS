//
//  FindQuestTableViewCell.swift
//  CampusFinder
//
//  Created by 강석호 on 10/2/24.
//

import UIKit
import SnapKit
import Kingfisher

final class FindQuestTableViewCell: BaseTableViewCell {
    
    let categoryView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "FFEEEE",
                                       alpha: 0.61)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hexCode: "F1DBDB").cgColor
        return view
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "급구"
        label.font = .pretendard(size: 14, weight: .medium)
        label.textColor = UIColor(hexCode: "FA5252")
        label.textAlignment = .center
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(size: 18, weight: .semibold)
        label.textColor = CFColor.black01
        label.numberOfLines = 2
        return label
    }()
    
    let priceTitle: UILabel = {
        let label = UILabel()
        label.text = "제시금액"
        label.font = .pretendard(size: 16, weight: .medium)
        label.textColor = CFColor.black02
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(size: 16, weight: .medium)
        label.textColor = CFColor.black01
        label.numberOfLines = 0
        return label
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(size: 14, weight: .medium)
        label.textColor = CFColor.black04
        label.numberOfLines = 0
        return label
    }()
    
    let posterImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star")
        view.backgroundColor = .gray
        return view
    }()
    
    var titleLabelWithCategoryTopConstraint: Constraint?
    var titleLabelWithoutCategoryTopConstraint: Constraint?
    
    override func configureHierarchy() {
        contentView.addSubview(categoryView)
        categoryView.addSubview(categoryLabel)
        contentView.addSubview(priceTitle)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(posterImageView)
    }
    
    override func configureLayout() {
        categoryView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(20)
            make.width.greaterThanOrEqualTo(categoryLabel.snp.width).offset(20)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            titleLabelWithCategoryTopConstraint = make.top.equalTo(categoryView.snp.bottom).offset(8).constraint
            titleLabelWithoutCategoryTopConstraint = make.top.equalToSuperview().inset(25).constraint
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(posterImageView.snp.leading).offset(-16)
        }
        
        priceTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(88)
            make.leading.equalToSuperview().inset(16)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(88)
            make.leading.equalTo(priceTitle.snp.trailing).offset(8)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().inset(16)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(94)
        }
        titleLabelWithoutCategoryTopConstraint?.deactivate()
        titleLabelWithCategoryTopConstraint?.activate()
    }
    
    func configure(with data: ListRequestPostResponse) {
        titleLabel.text = data.title
        nicknameLabel.text = data.nickname
        
        priceLabel.text = "\(data.money)원"
        
        if data.isUrgent {
            categoryView.isHidden = false
            titleLabelWithoutCategoryTopConstraint?.deactivate()
            titleLabelWithCategoryTopConstraint?.activate()
        } else {
            categoryView.isHidden = true
            titleLabelWithCategoryTopConstraint?.deactivate()
            titleLabelWithoutCategoryTopConstraint?.activate()
        }
        
        if let thumbnailURL = data.thumbnailImage, let url = URL(string: thumbnailURL) {
            posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        } else {
            posterImageView.image = UIImage(systemName: "photo")
        }
    }
}
