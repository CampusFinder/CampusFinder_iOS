//
//  UIImageView+.swift
//  CampusFinder
//
//  Created by 이빈 on 12/14/24.
//

import UIKit

extension UIImageView {
    
    func setImage(from urlString: String?, defaultColor: UIColor = .systemGray) {
        
        self.backgroundColor = defaultColor
        
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = nil
            return
        }
    
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.image = nil
                        self.backgroundColor = defaultColor
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.image = nil
                    self.backgroundColor = defaultColor
                }
            }
        }
    }
}
