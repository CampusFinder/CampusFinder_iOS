//
//  ProfileViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 8/25/24.
//

import UIKit
import SnapKit
import Then

final class ProfileViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    private let profileView = ProfileView()
    private let menuItems = ["내 게시글", "공지사항", "로그아웃", "회원탈퇴"]
    
    override func loadView() {
        self.view = profileView
        fetchProfileData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchProfileData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "마이페이지"
        configureTableView()
        configureGesture()
    }
    
    private func configureTableView() {
        profileView.profileMenuTableView.delegate = self
        profileView.profileMenuTableView.dataSource = self
    }
    
    private func configureGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapUserInfoView))
        profileView.userInfoView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapUserInfoView() {
        guard let userRole = UserManager.shared.getUserInfo()?.role else { return }
        
        if userRole == "STUDENT" {
            let studentVC = StudentProfileDetailViewController()
            navigationController?.pushViewController(studentVC, animated: true)
        } else if userRole == "PROFESSOR" {
            let professorVC = ProfProfileDetailViewController()
            navigationController?.pushViewController(professorVC, animated: true)
        } else {
            print("error")
        }
    }
    
    func fetchProfileData() {
        guard let userRole = UserManager.shared.getUserInfo()?.role else { return }
        
        if userRole == "STUDENT" {
            ProfileNetworkManager.shared.fetchStudentProfile { [weak self] result in
                switch result {
                case .success(let profile):
                    print("학생 프로필:", profile)
                    DispatchQueue.main.async {
                        if let imageUrl = profile.data.profileImageUrl, !imageUrl.isEmpty {
                            self?.profileView.profileImageView.setImage(from: imageUrl)
                        } else {
                            self?.profileView.profileImageView.backgroundColor = .gray
                        }
                        self?.profileView.userNameLabel.text = profile.data.nickname
                    }
                case .failure(let error):
                    print("학생 프로필 로드 실패:", error)
                }
            }
        } else if userRole == "PROFESSOR" {
            ProfileNetworkManager.shared.fetchProfessorProfile { [weak self] result in
                switch result {
                case .success(let profile):
                    print("교수 프로필:", profile)
                case .failure(let error):
                    print("교수 프로필 로드 실패:", error)
                }
                
            }
        }
    }
    
}


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileMenuTableViewCell.identifier, for: indexPath) as? ProfileMenuTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: menuItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(menuItems[indexPath.row]) 선택됨")
    }
}
