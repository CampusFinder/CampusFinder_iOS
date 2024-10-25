//
//  RefreshTokenManager.swift
//  CampusFinder
//
//  Created by 강석호 on 10/20/24.
//

import Foundation
import Alamofire
import RxSwift


final class RefreshTokenManager {
    
    static let shared = RefreshTokenManager()
    
    private let session: Session
    
    private init() {
        session = Session(interceptor: CFRequestInterceptor())
    }
    
    // MARK: 토큰 재발급
    func postRefreshToken() -> Observable<Result<RefreshModel, Error>> {
        return Observable.create { observer in
            do {
                let request = try Router.refresh.asURLRequest()
                self.session.request(request)
                    .responseDecodable(of: RefreshModel.self) { response in
                        switch response.result {
                        case .success(let success):
                            TokenManager.shared.token = success.accessToken
                            observer.onNext(.success(success))
                            observer.onCompleted()
                        case .failure(let error):
                            observer.onNext(.failure(error))
                            observer.onCompleted()
                        }
                    }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
