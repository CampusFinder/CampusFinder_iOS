//
//  TermsViewModel.swift
//  CampusFinder
//
//  Created by 강석호 on 8/11/24.
//

import RxSwift

class TermsViewModel {
    private let disposeBag = DisposeBag()
    
    let nextTapped = PublishSubject<Void>()
    
    let navigateToSelectPosition = PublishSubject<Void>()
    
    init() {
        nextTapped
            .bind(to: navigateToSelectPosition)
            .disposed(by: disposeBag)
    }
}
