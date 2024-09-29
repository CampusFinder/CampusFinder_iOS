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
    var viewModel = LoginViewModel()
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        bindNavigation()
    }
    
    func bindViewModel() {
        loginView.loginButton.rx.tap
            .bind(to: viewModel.logInTapped)
            .disposed(by: disposeBag)
        
        loginView.joinButton.rx.tap
            .bind(to: viewModel.joinTapped)
            .disposed(by: disposeBag)
    }
}

extension LoginViewController {
    func bindNavigation() {
        viewModel.navigateToMain
            .bind(with: self) { owner, _ in
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let rootVC = TabBarController()
                sceneDelegate?.window?.rootViewController = rootVC
                sceneDelegate?.window?.makeKeyAndVisible()
            }
            .disposed(by: disposeBag)
        
        viewModel.navigateToTerms
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(TermsViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
}
