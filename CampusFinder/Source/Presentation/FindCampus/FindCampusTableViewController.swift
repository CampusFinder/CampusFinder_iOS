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
    private var studentPosts: [ListStudentPostResponse] = []
    
    init(category: FinderCase) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
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
        // 여기서는 "DEV" 카테고리를 예시로 사용했습니다. 실제로는 선택된 카테고리에 따라 변경해야 합니다.
        StudentPostNetworkManager.shared.listStudentPost(categoryType: "DEV") { [weak self] result in
            switch result {
            case .success(let response):
                self?.studentPosts = response.data
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching student posts: \(error)")
                // 여기에 에러 처리 로직을 추가할 수 있습니다.
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
            return max(studentPosts.count, 1) // 최소 1개의 셀을 보여줌 (데이터가 없을 때 "No Data" 셀)
        case .request:
            return 0
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
            // request case는 아직 구현하지 않으므로 기본 셀 반환
            return UITableViewCell()
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
        let vc = DetailCampusViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
