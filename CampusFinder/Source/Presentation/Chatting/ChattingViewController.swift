//
//  ChattingViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 8/25/24.
//

import UIKit
import SnapKit

final class ChattingViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let headerView = UIView()
    let stackView = UIStackView()
    let horizontalLine = CFLine.lightGrayLine()
    let allDataButton = UIButton()
    let employmentButton = UIButton()
    let questButton = UIButton()
    let chattingTableView = UITableView()
    
    var messages: [String] = ["안녕하세요", "어떻게 도와드릴까요?", "문의사항이 있으면 연락 주세요!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    override func configureNavigation() {
        navigationItem.title = "채팅"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func configureHierarchy() {
        view.addSubview(headerView)
        headerView.addSubview(stackView)
        stackView.addArrangedSubview(allDataButton)
        stackView.addArrangedSubview(employmentButton)
        stackView.addArrangedSubview(questButton)
        stackView.addSubview(horizontalLine)
        view.addSubview(chattingTableView)
    }
    
    override func configureView() {
        headerView.backgroundColor = CFColor.Bg.gray01
        
        stackView.backgroundColor = CFColor.Bg.gray01
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        allDataButton.setTitle("전체", for: .normal)
        allDataButton.setTitleColor(CFColor.Primary.blue01, for: .normal)
        allDataButton.layer.cornerRadius = 15
        allDataButton.layer.borderWidth = 1
        allDataButton.layer.borderColor = CFColor.Primary.blue01.cgColor
        
        employmentButton.setTitle("고용", for: .normal)
        employmentButton.setTitleColor(CFColor.Primary.blue01, for: .normal)
        employmentButton.layer.cornerRadius = 15
        employmentButton.layer.borderWidth = 1
        employmentButton.layer.borderColor = CFColor.Primary.blue01.cgColor
        
        questButton.setTitle("의뢰", for: .normal)
        questButton.setTitleColor(CFColor.Primary.blue01, for: .normal)
        questButton.layer.cornerRadius = 15
        questButton.layer.borderWidth = 1
        questButton.layer.borderColor = CFColor.Primary.blue01.cgColor
    }
    
    override func configureConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(58)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(headerView.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(210)
        }
        
        horizontalLine.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(14)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        chattingTableView.snp.makeConstraints { make in
            make.top.equalTo(horizontalLine.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func configureTableView() {
        chattingTableView.dataSource = self
        chattingTableView.delegate = self
        chattingTableView.register(ChattingTableViewCell.self, forCellReuseIdentifier: ChattingTableViewCell.identifier)
        chattingTableView.backgroundColor = .white
        chattingTableView.rowHeight = 96
    }
}

extension ChattingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChattingTableViewCell.identifier, for: indexPath) as? ChattingTableViewCell else {
            return UITableViewCell()
        }
        
        let message = messages[indexPath.row]
        cell.configure(with: message)
        cell.backgroundColor = .white
        return cell
    }
}
