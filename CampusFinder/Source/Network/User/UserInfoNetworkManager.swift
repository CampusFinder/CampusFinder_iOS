//
//  UserInfoManager.swift
//  CampusFinder
//
//  Created by 이빈 on 12/13/24.
//

import Alamofire
import UIKit

final class UserInfoNetworkManager {
    static let shared = UserInfoNetworkManager()
    
    private init() {}
    
    func userInfo(completion: @escaping (Result<UserInfoModel, Error>) -> Void) {
        do {
            let request = try Router.userInfo.asURLRequest()
            AF.request(request).responseDecodable(of: UserInfoModel.self) { response in
                switch response.result {
                case .success(let userInfo):
                    completion(.success(userInfo))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
