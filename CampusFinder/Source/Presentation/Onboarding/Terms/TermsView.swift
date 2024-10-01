//
//  TermsView.swift
//  CampusFinder
//
//  Created by 강석호 on 8/11/24.
//

import UIKit
import SnapKit

final class TermsView: BaseView, UITableViewDataSource, UITableViewDelegate {
    
    let termsTitle = UILabel()
    let allSelectButton = UIButton()
    let allSelectLabel = UILabel()
    let crossLine = CFLine.lightGrayLine()
    let tableView = UITableView()
    let nextButton = CFButton.grayButton(title: "다음")
    
    private var isAllSelected = false
    
    private var terms: [(String, Bool)] = [
        ("만 14세 이상입니다. (필수)", false),
        ("이용약관 동의 (필수)", false),
        ("개인정보 처리방침 동의 (필수)", false),
        ("위치정보 이용 동의 (선택)", false),
        ("마케팅 정보 수신 동의 (선택)", false)
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        addSubview(termsTitle)
        addSubview(nextButton)
        addSubview(allSelectButton)
        addSubview(crossLine)
        addSubview(tableView)
        addSubview(allSelectLabel)
    }
    
    override func configureUI() {
        termsTitle.text = "캠퍼스파인더\n서비스 이용약관"
        termsTitle.textColor = .black
        termsTitle.font = .pretendard(size: 26, weight: .bold)
        termsTitle.numberOfLines = 0
        
        allSelectButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        allSelectButton.imageView?.contentMode = .scaleAspectFill
        allSelectButton.tintColor = CFColor.black02
        
        allSelectLabel.text = "모두 동의 (선택 정보 포함)"
        allSelectLabel.font = .pretendard(size: 16, weight: .medium)
        allSelectLabel.textColor = .black
    }
    
    override func configureConstraints() {
        termsTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(129)
        }
        
        allSelectButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(18)
            make.top.equalTo(termsTitle.snp.bottom).offset(44)
            make.size.equalTo(22)
        }
        
        allSelectLabel.snp.makeConstraints { make in
            make.leading.equalTo(allSelectButton.snp.trailing).offset(12)
            make.top.equalTo(termsTitle.snp.bottom).offset(44)
        }
        
        crossLine.snp.makeConstraints { make in
            make.top.equalTo(allSelectLabel.snp.bottom).offset(18)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(crossLine.snp.bottom).offset(18)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(300)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(60)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
    }
    
    override func configureAddTarget() {
        allSelectButton.addTarget(self, action: #selector(selectAllButtonTapped), for: .touchUpInside)
    }
    
    @objc private func selectAllButtonTapped() {
        isAllSelected.toggle()
        for index in terms.indices {
            terms[index].1 = isAllSelected
        }
        tableView.reloadData()
        updateNextButtonState()
    }
    
    @objc private func updateNextButtonState() {
        let requiredSelections = terms[0...2].allSatisfy { $0.1 }
        
        if requiredSelections {
            nextButton.backgroundColor = CFColor.Primary.blue01
            nextButton.setTitleColor(.white, for: .normal)
        } else {
            nextButton.backgroundColor = CFColor.Bg.gray03
            nextButton.setTitleColor(CFColor.black04, for: .normal)
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.register(TermsTableViewCell.self, forCellReuseIdentifier: "TermsCell")
        tableView.rowHeight = 44
        tableView.separatorStyle = .none
        tableView.backgroundColor = CFColor.Bg.gray01
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return terms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TermsCell", for: indexPath) as? TermsTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = CFColor.Bg.gray01
        cell.selectionStyle = .none
        
        let term = terms[indexPath.row].0
        let isSelected = terms[indexPath.row].1
        cell.configure(with: term)
        
        if isSelected {
            cell.checkButton.tintColor = CFColor.Primary.blue01
        } else {
            cell.checkButton.tintColor = CFColor.black02
        }

        cell.checkButton.addTarget(self, action: #selector(checkButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc private func checkButtonTapped(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? TermsTableViewCell,
              let indexPath = tableView.indexPath(for: cell) else { return }
        
        terms[indexPath.row].1.toggle()
        
        tableView.reloadRows(at: [indexPath], with: .none)
        
        updateNextButtonState()
    }
}
