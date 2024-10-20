//
//  StudentPostNetworkManager.swift
//  CampusFinder
//
//  Created by 강석호 on 10/11/24.
//

import Foundation
import Alamofire
import RxSwift

final class StudentPostNetworkManager {
    
    static let shared = StudentPostNetworkManager()
    
    private let session: Session
    
    private init() {
        session = Session(interceptor: CFRequestInterceptor())
    }
    
    // MARK: 학생찾기 글 조회
    func listStudentPost(categoryType: String, completion: @escaping (Result<ListStudentPostModel, Error>) -> Void) {
        do {
            let request = try Router.listStudentPost(categoryType: categoryType).asURLRequest()
            
            session.request(request).responseDecodable(of: ListStudentPostModel.self) { response in
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
    
    // MARK: 의뢰찾기 글 조회
    func listRequestPost(categoryType: String, completion: @escaping (Result<ListStudentPostModel, Error>) -> Void) {
        do {
            let request = try Router.listStudentPost(categoryType: categoryType).asURLRequest()
            
            session.request(request).responseDecodable(of: ListStudentPostModel.self) { response in
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
