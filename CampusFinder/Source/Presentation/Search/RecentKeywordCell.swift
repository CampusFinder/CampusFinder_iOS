//
//  RecentKeywordCell.swift
//  CampusFinder
//
//  Created by 강석호 on 9/23/24.
//

import UIKit
import SnapKit

final class RecentKeywordCell: UICollectionViewCell {
    
    static let identifier = "RecentKeywordCell"
    
    let keywordLabel = UILabel()
    let deleteButton = UIButton()
    
    var deleteButtonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = CFColor.Bg.gray03
        
        keywordLabel.font = .pretendard(size: 14, weight: .medium)
        keywordLabel.textColor = CFColor.black03
        keywordLabel.numberOfLines = 1
        contentView.addSubview(keywordLabel)
        
        deleteButton.addTarget(self, action: #selector(handleDeleteButton), for: .touchUpInside)
        deleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        deleteButton.tintColor = .black
        contentView.addSubview(deleteButton)
    }
    
    private func configureConstraints() {
        keywordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(9)
        }
    }
    
    @objc private func handleDeleteButton() {
        // 버튼이 눌리면 클로저를 실행
        deleteButtonTapped?()
    }
    
    func configure(with keyword: String) {
        keywordLabel.text = keyword
    }
}
