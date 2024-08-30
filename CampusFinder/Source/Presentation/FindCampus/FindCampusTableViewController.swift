//
//  FindCampusTableViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 8/30/24.
//

import UIKit
import SnapKit

final class FindCampusTableViewController: UITableViewController {
    
    var category: CategoryCase
    
    init(category: CategoryCase) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(FindCampusTableViewCell.self, forCellReuseIdentifier: "FindCampusTableViewCell")
        tableView.rowHeight = 130
        
        setupHeaderView()
    }
    
    private func setupHeaderView() {
        let headerView = FindCampusHeaderView()
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 45)
        headerView.setFilterAction(target: self, action: #selector(filterButtonTapped))

        tableView.tableHeaderView = headerView
    }
    
    @objc private func filterButtonTapped() {
        print("필터링 버튼이 눌렸습니다.")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.dummyData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FindCampusTableViewCell", for: indexPath) as? FindCampusTableViewCell else {
            return UITableViewCell()
        }
        let data = category.dummyData[indexPath.row]
        cell.configure(with: data)
        return cell
    }
}
