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
        itemImageView.contentMode = .scaleAspectFit
        
        itemLabel.textAlignment = .center
        itemLabel.font = .pretendard(size: 16, weight: .medium)
        itemLabel.textColor = .black
    }
    
    private func configureConstraints() {
        itemImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(56)
        }
        
        itemLabel.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
