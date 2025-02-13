//
//  ProfileNetworkManager.swift
//  CampusFinder
//
//  Created by 이빈 on 12/14/24.
//

import Alamofire
import UIKit

final class ProfileNetworkManager {
    static let shared = ProfileNetworkManager()
    
    private init() {}
    
    // 학생 프로필 가져오기
    func fetchStudentProfile(completion: @escaping (Result<StudentProfileModel, Error>) -> Void) {
        do {
            let request = try Router.studentMyPage.asURLRequest()
            AF.request(request).responseDecodable(of: StudentProfileModel.self) { response in
                switch response.result {
                case .success(let profile):
                    completion(.success(profile))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    // 학생 프로필 이미지 업데이트
    func updateStudentProfileImage(imageData: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let request = try Router.updateProfileImage(imageData: imageData).asURLRequest()
            AF.upload(multipartFormData: { formData in
                formData.append(imageData, withName: "file", fileName: "profile.jpg", mimeType: "image/jpeg")
            }, with: request)
            .response { response in
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
    
    // 학생 닉네임 업데이트
    func updateStudentNickname(nickname: String, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let request = try Router.updateNickname(nickname: nickname).asURLRequest()
            AF.request(request).response { response in
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
    
    // 학생 한 줄 소개 업데이트
    func updateStudentIntroduction(introduction: String, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let request = try Router.updateIntroduction(introduction: introduction).asURLRequest()
            AF.request(request).response { response in
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
    
    func fetchProfessorProfile(completion: @escaping (Result<ProfessorProfileModel, Error>) -> Void) {
        do {
            let request = try Router.professorMyPage.asURLRequest()
            AF.request(request).responseDecodable(of: ProfessorProfileModel.self) { response in
                switch response.result {
                case .success(let profile):
                    completion(.success(profile))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
