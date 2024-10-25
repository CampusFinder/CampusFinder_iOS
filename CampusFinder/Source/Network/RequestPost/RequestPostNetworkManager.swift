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
    
    // MARK: 의뢰찾기 글 상세 조회
    func detailRequestPost(boardIdx: Int, completion: @escaping (Result<DetailRequestPostModel, Error>) -> Void) {
        do {
            let request = try Router.detailRequestPost(boardIdx: boardIdx).asURLRequest()
            
            session.request(request).responseDecodable(of: DetailRequestPostModel.self) { response in
                completion(response.result.mapError { $0 as Error })
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func writeRequestPost(request: WriteRequestPostRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let router = Router.writeRequestPost(request: request)
            guard let multipartFormData = router.multipartFormData else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create multipart form data"])))
                return
            }
            
            let urlRequest = try router.asURLRequest()
            
            // Request 데이터 로깅
            print("\n=== Request Details ===")
            print("URL: \(urlRequest.url?.absoluteString ?? "")")
            print("Method: \(urlRequest.httpMethod ?? "")")
            print("Headers: \(urlRequest.allHTTPHeaderFields ?? [:])")
            
            // Request Body 데이터 확인
            print("\nRequest Body Values:")
            print("categoryType: \(request.categoryType)")
            print("title: \(request.title)")
            print("money: \(request.money)")
            print("isUrgent: \(request.isUrgent)")
            print("content: \(request.content)")
            print("deadline: \(request.deadline)")
            print("meetingType: \(request.meetingType)")
            print("isNegotiable: \(request.isNegotiable)")
            print("\nImage Upload Details:")
            for (index, image) in request.uploadImages.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 0.7) {
                    print("Image \(index + 1) size: \(ByteCountFormatter.string(fromByteCount: Int64(imageData.count), countStyle: .file))")
                }
            }
            print("=======================\n")
            
            session.upload(multipartFormData: multipartFormData, with: urlRequest)
                .response { response in
                    print("\n=== Response Details ===")
                    print("Status Code: \(response.response?.statusCode ?? 0)")
                    if let data = response.data,
                       let responseString = String(data: data, encoding: .utf8) {
                        print("Response: \(responseString)")
                    }
                    
                    switch response.result {
                    case .success:
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        } catch {
            completion(.failure(error))
        }
    }
}
