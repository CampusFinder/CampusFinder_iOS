//
//  FindCampusTableViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 8/30/24.
//

import UIKit
import SnapKit

final class FindCampusTableViewController: UITableViewController {
    deinit {
        print("deinit \(self)")
    }
    
    var category: FinderCase
    var categoryType: String
    private var studentPosts: [ListStudentPostResponse] = []
    private var requestPosts: [ListRequestPostResponse] = []
    
    init(category: FinderCase, categoryType: String) {
        self.category = category
        self.categoryType = categoryType
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(FindStudentTableViewCell.self, forCellReuseIdentifier: "FindStudentTableViewCell")
        tableView.register(FindQuestTableViewCell.self, forCellReuseIdentifier: "FindQuestTableViewCell")
        
        setupHeaderView()
        loadData()
    }
    
    private func loadData() {
        switch category {
        case .student:
            StudentPostNetworkManager.shared.listStudentPost(categoryType: categoryType) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.studentPosts = response.data
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching student posts: \(error)")
                }
            }
        case .request:
            RequestPostNetworkManager.shared.listRequestPost(categoryType: categoryType) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.requestPosts = response.data
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching request posts: \(error)")
                }
            }
        }
    }
    
    private func setupHeaderView() {
        let headerView = FindCampusHeaderView()
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 45)
        headerView.setFilterAction(target: self, action: #selector(filterButtonTapped))
        
        tableView.tableHeaderView = headerView
    }
    
    @objc private func filterButtonTapped() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let latestAction = UIAlertAction(title: "최신순", style: .default) { _ in
            print("최신순으로 정렬")
        }
        let lowPriceAction = UIAlertAction(title: "낮은 가격순", style: .default) { _ in
            print("낮은 가격순으로 정렬")
        }
        let highPriceAction = UIAlertAction(title: "높은 가격순", style: .default) { _ in
            print("높은 가격순으로 정렬")
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheet.addAction(latestAction)
        actionSheet.addAction(lowPriceAction)
        actionSheet.addAction(highPriceAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch category {
        case .student:
            return max(studentPosts.count, 1)
        case .request:
            return max(requestPosts.count, 1)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch category {
        case .student:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FindStudentTableViewCell", for: indexPath) as? FindStudentTableViewCell else {
                return UITableViewCell()
            }
            
            if !studentPosts.isEmpty && indexPath.row < studentPosts.count {
                let data = studentPosts[indexPath.row]
                cell.configure(with: data)
            } else {
                cell.configure(with: ListStudentPostResponse(boardIdx: 0, title: "No Data", nickname: "", thumbnailImage: nil, isNearCampus: false, categoryType: ""))
            }
            return cell
            
        case .request:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FindQuestTableViewCell", for: indexPath) as? FindQuestTableViewCell else {
                return UITableViewCell()
            }
            
            if !requestPosts.isEmpty && indexPath.row < requestPosts.count {
                let data = requestPosts[indexPath.row]
                cell.configure(with: data)
            } else {
                cell.configure(with: ListRequestPostResponse(boardIdx: 0, title: "No Data", nickname: "", thumbnailImage: nil, isUrgent: false, money: 0, categoryType: ""))
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch category {
        case .student:
            return 133
        case .request:
            return 150
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            switch category {
            case .student:
                if !studentPosts.isEmpty && indexPath.row < studentPosts.count {
                    let selectedPost = studentPosts[indexPath.row]
                    let detailVC = DetailPortfolioViewController(boardIdx: selectedPost.boardIdx)
                    navigationController?.pushViewController(detailVC, animated: true)
                }
            case .request:
                // 의뢰 게시글 상세 페이지로 이동하는 로직 (아직 구현되지 않음)
                break
            }
        }
}
