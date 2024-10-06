//
//  WelcomeViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 10/5/24.
//

import UIKit

final class WelcomeViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let welcomeView = WelcomeView()
    
    override func loadView() {
        self.view = welcomeView
    }
    
    override func configureTarget() {
        welcomeView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let rootVC = LoginViewController()
        let nav = UINavigationController(rootViewController: rootVC)
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
