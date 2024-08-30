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
    }
    
    func configureHierarchy() { }
    
    func configureView() { }
    
    func configureConstraints() { }
    
    func configureTarget() { }
    
    func configureNavigation() { }
}
