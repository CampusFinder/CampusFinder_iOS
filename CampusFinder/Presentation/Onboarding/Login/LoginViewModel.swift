//
//  LoginViewModel.swift
//  CampusFinder
//
//  Created by 강석호 on 8/10/24.
//

import RxSwift

class LoginViewModel {
    private let disposeBag = DisposeBag()
    
    let logInTapped = PublishSubject<Void>()
    let joinTapped = PublishSubject<Void>()
    
    let navigateToMain = PublishSubject<Void>()
    let navigateToTerms = PublishSubject<Void>()
    
    init() {
        logInTapped
            .bind(to: navigateToMain)
            .disposed(by: disposeBag)
        
        joinTapped
            .bind(to: navigateToTerms)
            .disposed(by: disposeBag)
    }
}
