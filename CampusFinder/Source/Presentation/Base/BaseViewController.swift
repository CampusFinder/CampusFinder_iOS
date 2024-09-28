//
//  BaseViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 8/7/24.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    final let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CFColor.Bg.gray01
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        configureHierarchy()
        configureView()
        configureConstraints()
        configureTarget()
        configureNavigation()
        hideKeyboard()
    }
    
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.dismissKeyboard)
        )
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func configureHierarchy() { }
    
    func configureView() { }
    
    func configureConstraints() { }
    
    func configureTarget() { }
    
    func configureNavigation() { }
}
