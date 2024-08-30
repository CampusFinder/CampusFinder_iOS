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
    var viewModel = PhoneNumberCertifyViewModel()
    
    override func loadView() {
        self.view = phoneNumberCertifyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        bindNavigation()
    }
    
    func bindViewModel() {
        phoneNumberCertifyView.nextButton.rx.tap
            .bind(to: viewModel.nextTapped)
            .disposed(by: disposeBag)
    }
}

extension PhoneNumberCertifyViewController {
    func bindNavigation() {
        
    }
}
