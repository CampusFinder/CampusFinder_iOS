//
//  ProfileViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 8/25/24.
//

import UIKit

final class ProfileViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
}
