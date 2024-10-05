//
//  NetworkManager.swift
//  CampusFinder
//
//  Created by 강석호 on 10/4/24.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let session: Session
    
    private init() {
        session = Session(interceptor: CFRequestInterceptor())
    }
    
    // MARK: 로그인
    func login(phoneNumber: String, password: String) -> Observable<Bool> {
        return Observable.create { observer in
            do {
                let query = SignInQuery(phoneNumber: phoneNumber, password: password)
                let request = try Router.signIn(query: query).asURLRequest()
                
                AF.request(request)
                    .responseDecodable(of: SignInResponse.self) { response in
                        switch response.result {
                        case .success(let success):
                            print(success)
                            TokenManager.shared.token = success.accessToken
                            TokenManager.shared.refreshToken = success.refreshToken
                            print("성공적 토큰 저장")
                            observer.onNext(true)
                            observer.onCompleted()
                            
                        case .failure(let failure):
                            print(failure)
                            observer.onNext(false)
                            observer.onCompleted()
                        }
                    }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    // MARK: 회원가입
    func signup(role: String, email: String, phoneNumber: String, password: String, nickname: String, univName: String) -> Observable<Bool> {
        return Observable.create { observer in
            do {
                let query = SignUpQuery(role: role, email: email, phoneNumber: phoneNumber, password: password, nickname: nickname, univName: univName)
                let request = try Router.signUp(query: query).asURLRequest()
                
                AF.request(request)
                    .responseDecodable(of: SignUpModel.self) { response in
                        switch response.result {
                        case .success(let success):
                            print(success)
                            observer.onNext(true)
                            observer.onCompleted()
                            
                        case .failure(let failure):
                            print(failure)
                            observer.onNext(false)
                            observer.onCompleted()
                        }
                    }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
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
