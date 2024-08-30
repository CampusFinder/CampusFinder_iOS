//
//  FindCollectionViewCell.swift
//  CampusFinder
//
//  Created by 강석호 on 8/12/24.
//

import UIKit
import SnapKit

class FindCollectionViewCell: UICollectionViewCell {
    
    static let id = "FindCollectionViewCell"
    
    let itemImageView = UIImageView()
    let itemLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(itemImageView)
        contentView.addSubview(itemLabel)
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        // ImageView 설정
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.image = UIImage(named: "testItem")
        
        // Label 설정
        itemLabel.textAlignment = .center
        itemLabel.font = UIFont.systemFont(ofSize: 15)
        itemLabel.textColor = .black
    }
    
    private func configureConstraints() {
        itemImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(50)
        }
        
        itemLabel.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
