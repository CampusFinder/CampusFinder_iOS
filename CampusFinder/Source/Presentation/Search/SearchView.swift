//
//  SearchView.swift
//  CampusFinder
//
//  Created by 강석호 on 9/22/24.
//

import UIKit
import SnapKit

final class SearchView: BaseView {
    
    let resultLabel = UILabel()
    let allDeleteButton = UIButton()
    let recentKeywordCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(resultLabel)
        addSubview(allDeleteButton)
        addSubview(recentKeywordCollectionView)
    }
    
    override func configureUI() {
        resultLabel.text = "최근 검색"
        resultLabel.font = .pretendard(size: 20, weight: .bold)
        resultLabel.textColor = .black
        
        allDeleteButton.setTitleColor(CFColor.black03, for: .normal)
        allDeleteButton.setTitle("전체 삭제", for: .normal)
        allDeleteButton.titleLabel?.font = .pretendard(size: 14, weight: .medium)
        allDeleteButton.backgroundColor = .clear
        
        recentKeywordCollectionView.backgroundColor = .clear
        recentKeywordCollectionView.register(RecentKeywordCell.self, forCellWithReuseIdentifier: RecentKeywordCell.identifier)
    }
    
    override func configureConstraints() {
        resultLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(125)
            make.leading.equalToSuperview().inset(16)
        }
        
        allDeleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(125)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(17)
            make.width.equalTo(70)
        }
        
        recentKeywordCollectionView.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}
