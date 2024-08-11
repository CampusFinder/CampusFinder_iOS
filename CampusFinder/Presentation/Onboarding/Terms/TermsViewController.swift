//
//  TermsViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 8/11/24.
//

import UIKit
import RxSwift

final class TermsViewController: BaseViewController {
    deinit {
        print("deinit: \(self)")
    }
    
    private let termsView = TermsView()
    var viewModel = TermsViewModel()
    
    override func loadView() {
        self.view = termsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        bindNavigation()
    }
    
    func bindViewModel() {
        termsView.nextButton.rx.tap
            .bind(to: viewModel.nextTapped)
            .disposed(by: disposeBag)
    }
}

extension TermsViewController {
    func bindNavigation() {
        viewModel.navigateToSelectPosition
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(SelectPositionViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
}
