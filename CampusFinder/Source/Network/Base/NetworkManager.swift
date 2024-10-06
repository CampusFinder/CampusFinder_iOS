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
    func login(phoneNumber: String, password: String, completion: @escaping (Bool) -> Void) {
        do {
            let query = SignInQuery(phoneNum: phoneNumber, password: password)
            let request = try Router.signIn(query: query).asURLRequest()
            
            AF.request(request)
                .responseDecodable(of: SignInModel.self) { response in
                    switch response.result {
                    case .success(let signInModel):
                        print(signInModel)
                        let signInResponse = signInModel.data
                        TokenManager.shared.token = signInResponse.accessToken
                        TokenManager.shared.refreshToken = signInResponse.refreshToken
                        print("성공적 토큰 저장")
                        completion(true)
                    case .failure(let error):
                        print("로그인 실패: \(error)")
                        completion(false)
                    }
                }
        } catch {
            print("Request error: \(error)")
            completion(false)
        }
    }
    
    // MARK: 이메일 인증번호 전송
    func emailSend(role: String, email: String, univName: String, completion: @escaping (Bool) -> Void) {
        do {
            let query = EmailSendQuery(role: role,
                                       email: email,
                                       univName: univName)
            let request = try Router.emailSend(query: query).asURLRequest()
            
            AF.request(request)
                .responseDecodable(of: EmailSendModel.self) { response in
                    switch response.result {
                    case .success:
                        completion(true)
                    case .failure(let error):
                        print("이메일 전송 실패: \(error)")
                        completion(false)
                    }
                }
        } catch {
            print("Request error: \(error)")
            completion(false)
        }
    }
    
    // MARK: 이메일 인증번호 검사
    func emailVerify(role: String, email: String, univName: String, code: String, completion: @escaping (Bool) -> Void) {
        do {
            let query = EmailVerifyQuery(role: role,
                                         email: email,
                                         univName: univName,
                                         code: code)
            let request = try Router.emailVerify(query: query).asURLRequest()
            
            AF.request(request)
                .responseDecodable(of: EmailVerifyModel.self) { response in
                    switch response.result {
                    case .success:
                        completion(true)
                    case .failure(let error):
                        print("인증 실패: \(error)")
                        completion(false)
                    }
                }
        } catch {
            print("Request error: \(error)")
            completion(false)
        }
    }
    
    // MARK: 휴대폰 인증번호 전송
    func smsSend(phoneNum: String, email: String, completion: @escaping (Bool) -> Void) {
        do {
            let query = SMSSendQuery(phoneNum: phoneNum,
                                     email: email)
            let request = try Router.smsSend(query: query).asURLRequest()
            
            AF.request(request)
                .responseDecodable(of: SMSSendModel.self) { response in
                    switch response.result {
                    case .success:
                        completion(true)
                    case .failure:
                        completion(false)
                    }
                }
        } catch {
            print("Request error: \(error)")
            completion(false)
        }
    }
    
    // MARK: 휴대폰 인증번호 검증
    func smsVerify(phoneNum: String, code: String, completion: @escaping (Bool, String?) -> Void) {
        do {
            let query = SMSVerifyQuery(phoneNum: phoneNum,
                                       code: code)
            let request = try Router.smsVerify(query: query).asURLRequest()
            
            AF.request(request)
                .responseDecodable(of: SMSVerifyModel.self) { response in
                    switch response.result {
                    case .success:
                        if let httpResponse = response.response {
                            if (200..<300).contains(httpResponse.statusCode) {
                                completion(true, nil)
                            } else if httpResponse.statusCode == 400 {
                                completion(false, "이미 요청된 핸드폰 번호입니다")
                            } else {
                                completion(false, "인증에 실패했습니다. 다시 시도해주세요.")
                            }
                        } else {
                            completion(false, "인증에 실패했습니다. 다시 시도해주세요.")
                        }
                    case .failure:
                        completion(false, "인증에 실패했습니다. 다시 시도해주세요.")
                    }
                }
        } catch {
            print("Request error: \(error)")
            completion(false, "요청을 처리할 수 없습니다.")
        }
    }
    
    // MARK: 닉네임 검증
    func nicknameVerify(nickname: String, completion: @escaping (Bool, String?) -> Void) {
        do {
            let query = NicknameVerifyQuery(nickname: nickname)
            let request = try Router.nicknameVerify(query: query).asURLRequest()
            
            AF.request(request)
                .responseDecodable(of: NicknameVerifyModel.self) { response in
                    switch response.result {
                    case .success:
                        if let httpResponse = response.response {
                            if httpResponse.statusCode == 200 {
                                completion(true, nil)
                            }
                            else if httpResponse.statusCode == 409 {
                                completion(false, "중복된 닉네임입니다")
                            }
                        }
                    case .failure:
                        completion(false, "요청할 수 없습니다")
                    }
                }
        } catch {
            print("Request error: \(error)")
            completion(false, nil)
        }
    }
    
    // MARK: 비밀번호 검증
    func passwordVerify(password: String, completion: @escaping (Bool, String?) -> Void) {
        do {
            let query = PasswordVerifyQuery(password: password)
            let request = try Router.passwordVerify(query: query).asURLRequest()
            
            AF.request(request)
                .responseDecodable(of: PasswordVerifyModel.self) { response in
                    switch response.result {
                    case .success:
                        if let httpResponse = response.response {
                            if httpResponse.statusCode == 200 {
                                completion(true, nil)
                            }
                            else if httpResponse.statusCode == 400 {
                                completion(false, "사용할 수 없는 비밀번호입니다")
                            }
                        }
                    case .failure:
                        completion(false, "요청할 수 없습니다")
                    }
                }
        } catch {
            print("Request error: \(error)")
            completion(false, nil)
        }
    }
    
    // MARK: 회원가입
    func signup(role: String, email: String, phoneNum: String, password: String, nickname: String, univName: String ,completion: @escaping (Bool, String?) -> Void) {
        do {
            let query = SignUpQuery(role: role,
                                    email: email,
                                    phoneNum: phoneNum,
                                    password: password,
                                    nickname: nickname,
                                    univName: univName)
            let request = try Router.signUp(query: query).asURLRequest()
            
            AF.request(request)
                .responseDecodable(of: SignUpModel.self) { response in
                    switch response.result {
                    case .success:
                        if let httpResponse = response.response {
                            if httpResponse.statusCode == 200 {
                                completion(true, nil)
                            }
                            else if httpResponse.statusCode == 400 {
                                completion(false, "회원가입에 실패하였습니다")
                            }
                            else if httpResponse.statusCode == 409 {
                                completion(false, "이메일 또는 전화번호가 중복되었습니다")
                            }
                        }
                    case .failure:
                        completion(false, "요청할 수 없습니다")
                    }
                }
        } catch {
            print("Request error: \(error)")
            completion(false, nil)
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
