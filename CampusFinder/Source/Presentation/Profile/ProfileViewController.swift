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
        print("click")
        let vc = StudentProfileDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
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
