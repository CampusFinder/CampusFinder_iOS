//
//  FindCampusTableViewCell.swift
//  CampusFinder
//
//  Created by 강석호 on 8/30/24.
//

import UIKit
import SnapKit

final class FindCampusTableViewCell: BaseTableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(size: 18, weight: .semibold)
        label.textColor = CFColor.black01
        label.numberOfLines = 2
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(size: 16, weight: .medium)
        label.textColor = CFColor.black02
        label.numberOfLines = 0
        return label
    }()
    
    let posterImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star")
        view.backgroundColor = .gray
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(posterImageView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(posterImageView.snp.leading).inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(posterImageView.snp.leading).inset(16)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(93)
        }
    }
    
    func configure(with data: DummyData) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
    }
}
