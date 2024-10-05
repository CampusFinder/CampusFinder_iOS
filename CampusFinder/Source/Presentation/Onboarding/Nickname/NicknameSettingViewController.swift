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
        nicknameSettingView.comfirmButton.addTarget(self, action: #selector(comfirmButtonClicked), for: .touchUpInside)
        
        nicknameSettingView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc func nextButtonClicked() {
        let vc = PasswordSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func comfirmButtonClicked() {
        guard let nickname = nicknameSettingView.nicknameTextField.text
        else {
            return
        }
        
        NetworkManager.shared.nicknameVerify(nickname: nickname) { [weak self] isSuccess, errorMessage  in
            DispatchQueue.main.async {
                if isSuccess {
                    SignupData.shared.nickname = nickname
                    self?.showAlert(title: "사용할 수 있는 닉네임입니다", message: nil)
                    self?.nicknameSettingView.nextButton.backgroundColor = CFColor.Primary.blue01
                    self?.nicknameSettingView.nextButton.setTitleColor(.white, for: .normal)
                    self?.nicknameSettingView.nextButton.isEnabled = true
                } else {
                    let message = errorMessage ?? "다시 시도해주세요"
                    self?.showAlert(title: message, message: nil)
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
