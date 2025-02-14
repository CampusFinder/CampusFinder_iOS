//
//  LoginViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 8/7/24.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: BaseViewController {
    deinit {
        print("deinit: \(self)")
    }
    
    private let loginView = LoginView()
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureTarget() {
        loginView.joinButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        
        loginView.loginButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    }
    
    @objc func signUpButtonClicked() {
        let vc = TermsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func signInButtonClicked() {
        guard let phoneNum = loginView.phoneNumberField.text,
              let password = loginView.passwordField.text else {
            return
        }
        
        OnboardingNetworkManager.shared.login(phoneNumber: phoneNum, password: password) { [weak self] isSuccess in
            DispatchQueue.main.async {
                if isSuccess {
//                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
//                    let rootVC = TabBarController()
//                    sceneDelegate?.window?.rootViewController = rootVC
//                    sceneDelegate?.window?.makeKeyAndVisible()
                    self?.fetchUserInfo()
                } else {
                    self?.showAlert()
                }
            }
        }
    }
    
    private func fetchUserInfo() {
        UserInfoNetworkManager.shared.userInfo { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userInfoModel):
                    UserManager.shared.saveUserInfo(userInfoModel.data)
                    self?.navigateToHome()
                case .failure(let error):
                    self?.showAlert()
                }
            }
        }
    }
    
    private func navigateToHome() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let rootVC = TabBarController()
        sceneDelegate?.window?.rootViewController = rootVC
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "로그인에 실패했습니다", message: "다시 시도해주세요.", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
