//
//  NicknameSettingViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 10/3/24.
//

import UIKit

final class NicknameSettingViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let nicknameSettingView = NicknameSettingView()
    
    override func loadView() {
        self.view = nicknameSettingView
    }
    
    override func configureNavigation() {
        navigationItem.title = "닉네임 설정"
    }
    
    override func configureTarget() {
        nicknameSettingView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc func nextButtonClicked() {
        let vc = PasswordSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
