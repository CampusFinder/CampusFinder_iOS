//
//  RoleCertifyViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 10/3/24.
//

import UIKit

final class RoleCertifyViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let roleCertifyView = RoleCertifyView()
    
    override func loadView() {
        self.view = roleCertifyView
    }
    
    override func configureTarget() {
        roleCertifyView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc func nextButtonClicked() {
        let vc = PhoneNumberCertifyViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
