//
//  TermsTableViewCell.swift
//  CampusFinder
//
//  Created by 강석호 on 10/1/24.
//

import UIKit
import SnapKit

final class TermsTableViewCell: BaseTableViewCell {
    
    let checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = CFColor.black02
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(size: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    let viewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("보기", for: .normal)
        button.titleLabel?.font = .pretendard(size: 14, weight: .regular)
        button.setTitleColor(CFColor.black03, for: .normal)
        return button
    }()

    override func configureHierarchy() {
        contentView.addSubview(checkButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(viewButton)
    }
    
    override func configureLayout() {
        checkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(22)
            make.size.equalTo(18)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(checkButton.snp.trailing).offset(14)
        }
        viewButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(18)
            make.height.equalTo(21)
            make.width.equalTo(26)
        }
    }
    
    override func configureView() {
        checkButton.addTarget(self, action: #selector(checkmarkButtonTapped), for: .touchUpInside)
        viewButton.addTarget(self, action: #selector(viewButtonTapped), for: .touchUpInside)
    }
    
    @objc private func checkmarkButtonTapped() {
        checkButton.isSelected.toggle()
        if checkButton.isSelected {
            checkButton.tintColor = CFColor.Primary.blue01
        } else {
            checkButton.tintColor = CFColor.black02
        }
    }
    
    @objc private func viewButtonTapped() {
        print("보기 버튼 클릭됨")
    }
    
    func configure(with title: String, isSelected: Bool) {
        titleLabel.text = title
        checkButton.tintColor = isSelected ? CFColor.Primary.blue01 : CFColor.black02
    }
}
