//
//  CFSearchView.swift
//  CampusFinder
//
//  Created by 강석호 on 8/12/24.
//

import UIKit
import SnapKit

class CFSearchView: BaseView {

    let searchImageView = UIImageView()
    let searchPlaceHolder = UILabel()
    
    override func configureHierarchy() {
        addSubview(searchImageView)
        addSubview(searchPlaceHolder)
    }
    
    override func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemBlue.cgColor
        
        searchImageView.image = UIImage(systemName: "magnifyingglass")
        searchImageView.tintColor = .systemBlue
        
        searchPlaceHolder.text = "원하는 의뢰내용을 찾아보세요"
        searchPlaceHolder.textColor = .systemBlue
        searchPlaceHolder.font = .systemFont(ofSize: 15)
    }
    
    override func configureConstraints() {
        searchImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        
        searchPlaceHolder.snp.makeConstraints { make in
            make.leading.equalTo(searchImageView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
