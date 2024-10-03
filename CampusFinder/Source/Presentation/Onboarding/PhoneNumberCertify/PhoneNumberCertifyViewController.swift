//
//  PhoneNumberCertifyViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 8/11/24.
//

import UIKit
import RxSwift
import RxCocoa

final class PhoneNumberCertifyViewController: BaseViewController {
    deinit {
        print("deinit: \(self)")
    }
    
    private let phoneNumberCertifyView = PhoneNumberCertifyView()
    
    override func loadView() {
        self.view = phoneNumberCertifyView
    }
    
    override func configureNavigation() {
        navigationItem.title = "휴대폰 인증"
    }
    
    override func configureTarget() {
        phoneNumberCertifyView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc func nextButtonClicked() {
        let vc = NicknameSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

