//
//  RequestPostNetworkManager.swift
//  CampusFinder
//
//  Created by 강석호 on 10/20/24.
//

import Foundation
import Alamofire
import RxSwift

final class RequestPostNetworkManager {
    
    static let shared = RequestPostNetworkManager()
    
    private let session: Session
    
    private init() {
        session = Session(interceptor: CFRequestInterceptor())
    }
    
    // MARK: 의뢰찾기 글 조회
    func listRequestPost(categoryType: String, completion: @escaping (Result<ListRequestPostModel, Error>) -> Void) {
        do {
            let request = try Router.listRequestPost(categoryType: categoryType).asURLRequest()
            
            session.request(request).responseDecodable(of: ListRequestPostModel.self) { response in
                switch response.result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
