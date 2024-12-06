//
//  MenuTableViewCell.swift
//  CampusFinder
//
//  Created by 이빈 on 12/6/24.
//

import UIKit
import SnapKit
import Then

final class ProfileMenuTableViewCell: BaseTableViewCell {
    static let identifier = "ProfileMenuTableViewCell"
    
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.layer.borderColor = UIColor.systemGray6.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    private let arrowImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .darkGray
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        configureHierarchy()
        configureLayout()
    }
    
    override func configureHierarchy() {
        [titleLabel, arrowImageView].forEach {
            containerView.addSubview($0)
        }
        
        contentView.addSubview(containerView)
    }
    
    override func configureLayout() {
        
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.height.equalTo(73)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(15)
        }
    }
    
    func configure(with data: String) {
        titleLabel.text = data
    }
    
}
