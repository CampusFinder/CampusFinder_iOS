//
//  CFAddPhotoView.swift
//  CampusFinder
//
//  Created by 강석호 on 9/8/24.
//

import UIKit
import SnapKit

class CFAddPhotoView: BaseView {
    
    let addPhotoImageView = UIImageView()
    let photoCountLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(addPhotoImageView)
        addSubview(photoCountLabel)
    }
    
    override func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        
        addPhotoImageView.image = UIImage(named: "addPhoto")
        addPhotoImageView.contentMode = .scaleAspectFit
        
        photoCountLabel.text = "0/6"
        photoCountLabel.font = .pretendard(size: 14, weight: .regular)
        photoCountLabel.textColor = CFColor.black03
        photoCountLabel.textAlignment = .center
    }
    
    override func configureConstraints() {
        addPhotoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-6)
            make.size.equalTo(20)
        }
        photoCountLabel.snp.makeConstraints { make in
            make.top.equalTo(addPhotoImageView.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
}
