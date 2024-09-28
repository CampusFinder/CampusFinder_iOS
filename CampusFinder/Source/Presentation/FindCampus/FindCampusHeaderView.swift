//
//  FindCampusHeaderView.swift
//  CampusFinder
//
//  Created by 강석호 on 8/30/24.
//

import UIKit
import SnapKit

class FindCampusHeaderView: UIView {
    
    private let filterButton: UIButton = {
        let button = UIButton()
        button.setTitle("최신순", for: .normal)
        button.setTitleColor(CFColor.black01, for: .normal)
        button.titleLabel?.font = .pretendard(size: 14, weight: .medium)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = CFColor.black01
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = CFColor.Bg.gray03
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(filterButton)
        addSubview(separatorLine)
    }
    
    private func setupConstraints() {
        filterButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
        }
        separatorLine.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func setFilterAction(target: Any?, action: Selector) {
        filterButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
