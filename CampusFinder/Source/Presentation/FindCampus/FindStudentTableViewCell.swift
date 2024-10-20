//
//  FindStudentTableViewCell.swift
//  CampusFinder
//
//  Created by 강석호 on 8/30/24.
//

import UIKit
import SnapKit
import Kingfisher

final class FindStudentTableViewCell: BaseTableViewCell {
    
    let categoryView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "EAF9F2")
        view.layer.cornerRadius = 8
        return view
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "학교근처 거주"
        label.font = .pretendard(size: 14, weight: .medium)
        label.textColor = UIColor(hexCode: "00C170")
        label.textAlignment = .center
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(size: 18, weight: .semibold)
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(posterImageView)
    }
    
    override func configureLayout() {
        categoryView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(20)
            make.width.greaterThanOrEqualTo(categoryLabel.snp.width).offset(20)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            titleLabelWithCategoryTopConstraint = make.top.equalTo(categoryView.snp.bottom).offset(8).constraint
            titleLabelWithoutCategoryTopConstraint = make.top.equalToSuperview().inset(18).constraint
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(posterImageView.snp.leading).offset(-16)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(18)
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
    
    func configure(with data: ListStudentPostResponse) {
        titleLabel.text = data.title
        nicknameLabel.text = data.nickname
        
        if data.isNearCampus {
            categoryView.isHidden = false
            titleLabelWithoutCategoryTopConstraint?.deactivate()
            titleLabelWithCategoryTopConstraint?.activate()
        } else {
            categoryView.isHidden = true
            titleLabelWithCategoryTopConstraint?.deactivate()
            titleLabelWithoutCategoryTopConstraint?.activate()
        }
        
        if let thumbnailURL = data.thumbnailImage, !thumbnailURL.isEmpty {
            posterImageView.kf.setImage(with: URL(string: thumbnailURL), placeholder: UIImage(systemName: "photo"))
        } else {
            posterImageView.image = UIImage(systemName: "photo")
        }
    }
}
