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
    private var isPasswordVerified = false
    
    override func loadView() {
        self.view = passwordSettingView
    }
    
    override func configureNavigation() {
        navigationItem.title = "비밀번호 설정"
    }
    
    override func configureTarget() {
        passwordSettingView.passwordButton.addTarget(self, action: #selector(passwordButtonClicked), for: .touchUpInside)
        
        passwordSettingView.nextButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        
        passwordSettingView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        passwordSettingView.passwordCheckTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
    }
    
    @objc func passwordButtonClicked() {
        guard let password = passwordSettingView.passwordTextField.text else {
            return
        }
        
        OnboardingNetworkManager.shared.passwordVerify(password: password) { [weak self] isSuccess, errorMessage in
            DispatchQueue.main.async {
                if isSuccess {
                    SignupData.shared.password = password
                    self?.isPasswordVerified = true
                    self?.showAlert(title: "사용할 수 있는 비밀번호입니다", message: nil)
                } else {
                    self?.isPasswordVerified = false
                    let message = errorMessage ?? "다시 시도해주세요"
                    self?.showAlert(title: message, message: nil)
                }
                self?.updateNextButtonState()
            }
        }
    }
    
    @objc func signUpButtonClicked() {
        guard let password = passwordSettingView.passwordTextField.text,
              let role = SignupData.shared.role,
              let email = SignupData.shared.email,
              let phoneNum = SignupData.shared.phoneNumber,
              let nickname = SignupData.shared.nickname,
              let univName = SignupData.shared.univName else {
            return
        }
        
        print(role, email, phoneNum, password, nickname, univName)

        OnboardingNetworkManager.shared.signup(role: role, email: email, phoneNum: phoneNum, password: password, nickname: nickname, univName: univName) { [weak self] isSuccess, errorMessage in
            DispatchQueue.main.async {
                if isSuccess {
                    let vc = WelcomeViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                    SignupData.shared.reset()
                } else {
                    let message = errorMessage ?? "다시 시도해주세요"
                    self?.showAlert(title: message, message: nil)
                }
            }
        }
    }
    
    @objc func passwordTextFieldDidChange() {
        let password = passwordSettingView.passwordTextField.text ?? ""
        let passwordCheck = passwordSettingView.passwordCheckTextField.text ?? ""
        
        if passwordCheck.isEmpty {
            passwordSettingView.matchingStatusLabel.text = ""
        } else if password == passwordCheck {
            passwordSettingView.matchingStatusLabel.text = "비밀번호가 일치합니다."
            passwordSettingView.matchingStatusLabel.textColor = CFColor.Primary.blue01
        } else {
            passwordSettingView.matchingStatusLabel.text = "비밀번호가 일치하지 않습니다."
            passwordSettingView.matchingStatusLabel.textColor = .systemRed
        }
        
        updateNextButtonState()
    }
    
    private func updateNextButtonState() {
        let password = passwordSettingView.passwordTextField.text ?? ""
        let passwordCheck = passwordSettingView.passwordCheckTextField.text ?? ""
        
        if password == passwordCheck && isPasswordVerified {
            passwordSettingView.nextButton.backgroundColor = CFColor.Primary.blue01
            passwordSettingView.nextButton.setTitleColor(.white, for: .normal)
            passwordSettingView.nextButton.isEnabled = true
        } else {
            passwordSettingView.nextButton.backgroundColor = CFColor.Bg.gray03
            passwordSettingView.nextButton.setTitleColor(CFColor.black04, for: .normal)
            passwordSettingView.nextButton.isEnabled = false
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
