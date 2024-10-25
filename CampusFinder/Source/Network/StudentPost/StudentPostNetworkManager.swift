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
    
    // MARK: 학생찾기 글 작성 (Multipart)
    func writePortfolio(request: WritePortfolioRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let router = Router.writePortfolio(request: request)
            guard let multipartFormData = router.multipartFormData else {
                print("Failed to create multipart form data")
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create multipart form data"])))
                return
            }
            
            let urlRequest = try router.asURLRequest()
            print("\n=== Request Details ===")
            print("URL: \(urlRequest.url?.absoluteString ?? "")")
            print("Method: \(urlRequest.httpMethod ?? "")")
            print("Headers: \(urlRequest.allHTTPHeaderFields ?? [:])")
            
            // 요청 데이터 확인을 위한 딕셔너리 생성
            let requestData: [String: Any] = [
                "categoryType": request.categoryType,
                "title": request.title,
                "isNearCampus": request.isNearCampus,
                "meetingType": request.meetingType,
                "content": request.content
            ]
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: requestData),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Request Data: \(jsonString)")
            }
            print("===================\n")
            
            session.upload(multipartFormData: multipartFormData, with: urlRequest)
                .response { response in
                    print("\n=== Response Details ===")
                    print("Status Code: \(response.response?.statusCode ?? 0)")
                    if let data = response.data,
                       let responseString = String(data: data, encoding: .utf8) {
                        print("Response: \(responseString)")
                    }
                    print("===================\n")
                    
                    switch response.result {
                    case .success:
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        } catch {
            print("Error creating request: \(error)")
            completion(.failure(error))
        }
    }
}
