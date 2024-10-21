//
//  StudentPostNetworkManager.swift
//  CampusFinder
//
//  Created by 강석호 on 10/11/24.
//

import Foundation
import Alamofire

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
                completion(response.result.mapError { $0 as Error })
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    // MARK: 학생찾기 글 상세 조회
    func detailStudentPost(boardIdx: Int, completion: @escaping (Result<DetailStudentPostModel, Error>) -> Void) {
        do {
            let request = try Router.detailStudentPost(boardIdx: boardIdx).asURLRequest()

            session.request(request).responseDecodable(of: DetailStudentPostModel.self) { response in
                completion(response.result.mapError { $0 as Error })
            }
        } catch {
            completion(.failure(error))
        }
    }
}
