//
//  PasswordSettingViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 10/3/24.
//

import UIKit

final class PasswordSettingViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let passwordSettingView = PasswordSettingView()
    
    override func loadView() {
        self.view = passwordSettingView
    }
    
    override func configureNavigation() {
        navigationItem.title = "비밀번호 설정"
    }
    
}
