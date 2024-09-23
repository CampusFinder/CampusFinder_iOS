//
//  CFSearchBar.swift
//  CampusFinder
//
//  Created by 강석호 on 9/22/24.
//

import UIKit
import SnapKit

class CFSearchBar: BaseView {

    let searchImageView = UIImageView()
    let searchTextField = UITextField()
    
    override func configureHierarchy() {
        addSubview(searchImageView)
        addSubview(searchTextField)
    }
    
    override func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = CFColor.black04.cgColor
        
        searchImageView.image = UIImage(systemName: "magnifyingglass")
        searchImageView.tintColor = CFColor.black01
        
        searchTextField.placeholder = "원하는 의뢰내용을 찾아보세요"
        searchTextField.textColor = CFColor.black01
        searchTextField.font = .systemFont(ofSize: 15)
        searchTextField.borderStyle = .none
    }
    
    override func configureConstraints() {
        searchImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(searchImageView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
