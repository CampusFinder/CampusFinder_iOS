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
        roleCertifyView.emailButton.addTarget(self, action: #selector(emailButtonClicked), for: .touchUpInside)
        
        roleCertifyView.certifyNumberButton.addTarget(self, action: #selector(certifyNumberButtonClicked), for: .touchUpInside)
        
        roleCertifyView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc func nextButtonClicked() {
        let vc = PhoneNumberCertifyViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func emailButtonClicked() {
        guard let role = SignupData.shared.role,
              let univName = roleCertifyView.campusTextField.text,
              let email = roleCertifyView.emailTextField.text else {
            return
        }
        
        print(role, univName, email)
        
        NetworkManager.shared.emailSend(role: role, email: email, univName: univName){ [weak self] isSuccess in
            DispatchQueue.main.async {
                if isSuccess {
                    self?.showAlert(title: "전송 완료했습니다",
                                    message: "학교 이메일을 통해 확인해주세요")
                } else {
                    self?.showAlert(title: "전송에 실패했습니다",
                                    message: nil)
                }
            }
        }
    }
    
    @objc func certifyNumberButtonClicked() {
        guard let role = SignupData.shared.role,
              let univName = roleCertifyView.campusTextField.text,
              let email = roleCertifyView.emailTextField.text,
              let code = roleCertifyView.certifyNumberTextField.text
        else {
            return
        }
        
        print(role, univName, email, code)
        
        NetworkManager.shared.emailVerify(role: role, email: email, univName: univName, code: code){ [weak self] isSuccess in
            DispatchQueue.main.async {
                if isSuccess {
                    SignupData.shared.email = email
                    SignupData.shared.univName = univName
                    self?.showAlert(title: "인증되었습니다",
                                    message: nil)
                    self?.roleCertifyView.nextButton.backgroundColor = CFColor.Primary.blue01
                    self?.roleCertifyView.nextButton.setTitleColor(.white, for: .normal)
                    self?.roleCertifyView.nextButton.isEnabled = true
                } else {
                    self?.showAlert(title: "인증에 실패했습니다",
                                    message: "다시 시도해주세요")
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
