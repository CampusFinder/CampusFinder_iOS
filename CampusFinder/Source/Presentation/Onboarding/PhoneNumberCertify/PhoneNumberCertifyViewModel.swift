//
//  PhoneNumberCertifyViewModel.swift
//  CampusFinder
//
//  Created by 강석호 on 8/11/24.
//

import RxSwift

class PhoneNumberCertifyViewModel {
    private let disposeBag = DisposeBag()
    
    let nextTapped = PublishSubject<Void>()
    
    let navigateToPhoneNumberCertify = PublishSubject<Void>()
    
    init() {
        nextTapped
            .bind(to: navigateToPhoneNumberCertify)
            .disposed(by: disposeBag)
    }
}
