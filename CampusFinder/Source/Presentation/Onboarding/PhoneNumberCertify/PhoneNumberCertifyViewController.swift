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
        phoneNumberCertifyView.sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
        
        phoneNumberCertifyView.confirmButton.addTarget(self, action: #selector(certifyNumberButtonClicked), for: .touchUpInside)
        
        phoneNumberCertifyView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc func nextButtonClicked() {
        let vc = NicknameSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func sendButtonClicked() {
        guard let email = SignupData.shared.email,
              let phoneNum = phoneNumberCertifyView.phoneNumberTextField.text
        else {
            return
        }
        
        OnboardingNetworkManager.shared.smsSend(phoneNum: phoneNum, email: email) { [weak self] isSuccess in
            DispatchQueue.main.async {
                if isSuccess {
                    SignupData.shared.email = email
                    self?.showAlert(title: "전송되었습니다",
                                    message: nil)
                } else {
                    self?.showAlert(title: "전송에 실패했습니다",
                                    message: "다시 시도해주세요")
                }
            }
        }
    }
    
    @objc func certifyNumberButtonClicked() {
        guard let phoneNum = phoneNumberCertifyView.phoneNumberTextField.text,
              let code = phoneNumberCertifyView.certifyNumberTextField.text
        else {
            return
        }
        
        OnboardingNetworkManager.shared.smsVerify(phoneNum: phoneNum, code: code){ [weak self] isSuccess, errorMessage in
            DispatchQueue.main.async {
                if isSuccess {
                    SignupData.shared.phoneNumber = phoneNum
                    self?.showAlert(title: "인증되었습니다", message: nil)
                    self?.phoneNumberCertifyView.nextButton.backgroundColor = CFColor.Primary.blue01
                    self?.phoneNumberCertifyView.nextButton.setTitleColor(.white, for: .normal)
                    self?.phoneNumberCertifyView.nextButton.isEnabled = true
                } else {
                    let message = errorMessage ?? "다시 시도해주세요"
                    self?.showAlert(title: "인증에 실패했습니다", message: message)
                }
            }
        }
    }
    
    private func showAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
