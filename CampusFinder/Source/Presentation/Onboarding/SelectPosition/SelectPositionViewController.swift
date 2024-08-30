//
//  SelectPositionViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 8/11/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SelectPositionViewController: BaseViewController {
    deinit {
        print("deinit: \(self)")
    }
    
    private let selectPositionView = SelectPositionView()
    var viewModel = SelectPositionViewModel()
    
    override func loadView() {
        self.view = selectPositionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        bindNavigation()
    }
    
    func bindViewModel() {
        selectPositionView.nextButton.rx.tap
            .bind(to: viewModel.nextTapped)
            .disposed(by: disposeBag)
    }
}

extension SelectPositionViewController {
    func bindNavigation() {
        viewModel.navigateToPhoneNumberCertify
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(PhoneNumberCertifyViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
}
