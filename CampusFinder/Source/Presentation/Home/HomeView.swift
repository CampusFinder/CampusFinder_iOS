//
//  HomeView.swift
//  CampusFinder
//
//  Created by 강석호 on 8/11/24.
//

import UIKit
import SnapKit

final class HomeView: BaseView {
    
    let logoImageView = UIImageView()
    let searchView = CFSearchView()
    let searchButton = UIButton()
    let findLabel = UILabel()
    let findCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    let professorView = ProfessorView()
    let professorButton = UIButton()
    
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let totalCellHeight = (100 * 2) + 10
        let collectionViewHeight = 250
        let topInset = (collectionViewHeight - totalCellHeight) / 2
        layout.sectionInset = UIEdgeInsets(top: CGFloat(topInset), left: 0, bottom: 0, right: 0)
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(logoImageView)
        addSubview(searchView)
        addSubview(searchButton)
        addSubview(findLabel)
        addSubview(findCollectionView)
        addSubview(professorView)
        professorView.addSubview(professorButton)
    }
    
    override func configureUI() {
        logoImageView.image = UIImage(named: "homeLogo")
        logoImageView.contentMode = .scaleAspectFit
        
        searchButton.backgroundColor = .clear
        
        findLabel.text = "찾아보기"
        findLabel.font = .pretendard(size: 24, weight: .bold)
        findLabel.textColor = .black
        
        findCollectionView.register(FindCollectionViewCell.self, forCellWithReuseIdentifier: FindCollectionViewCell.id)
        findCollectionView.backgroundColor = .white
        findCollectionView.isScrollEnabled = false
        findCollectionView.layer.cornerRadius = 10
        
        professorView.backgroundColor = .white
        professorView.layer.cornerRadius = 10
        
        professorButton.backgroundColor = .clear
    }
    
    override func configureConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(73)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(26)
            make.width.equalTo(155)
        }
        
        searchView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        findLabel.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(50)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        findCollectionView.snp.makeConstraints { make in
            make.top.equalTo(findLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(250)
        }
        
        professorView.snp.makeConstraints { make in
            make.top.equalTo(findCollectionView.snp.bottom).offset(36)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(129)
        }
        
        professorButton.snp.makeConstraints { make in
            make.edges.equalTo(professorView)
        }
    }
}
