//
//  SearchResultTableViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 9/23/24.
//

import UIKit
import SnapKit

final class SearchResultTableViewController: UITableViewController {
    deinit {
        print("deinit \(self)")
    }
    
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
        
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: "SearchResultTableViewCell")
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
        return category.dummyData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as? SearchResultTableViewCell else {
            return UITableViewCell()
        }
        let data = category.dummyData[indexPath.row]
        cell.configure(with: data)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailCampusViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
