//
//  CFSelectView.swift
//  CampusFinder
//
//  Created by 강석호 on 9/6/24.
//

import UIKit
import SnapKit

class CFSelectView: BaseView {

    let selectImageView = UIImageView()
    
    override func configureHierarchy() {
        addSubview(selectImageView)
    }
    
    override func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        
        selectImageView.image = UIImage(systemName: "chevron.down")
        selectImageView.tintColor = CFColor.black01
    }
    
    override func configureConstraints() {
        selectImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.size.equalTo(18)
        }
    }
}
