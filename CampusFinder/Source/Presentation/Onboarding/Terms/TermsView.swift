//
//  TermsView.swift
//  CampusFinder
//
//  Created by 강석호 on 8/11/24.
//

import UIKit
import SnapKit

final class TermsView: BaseView, UITableViewDataSource, UITableViewDelegate {
    var terms: [(String, Bool)]
    let termsTitle = UILabel()
    let allSelectButton = UIButton()
    let allSelectLabel = UILabel()
    let crossLine = CFLine.lightGrayLine()
    let tableView = UITableView()
    let nextButton = CFButton.grayButton(title: "다음")
    
    init() {
        self.terms = [
            ("만 14세 이상입니다. (필수)", false),
            ("이용약관 동의 (필수)", false),
            ("개인정보 처리방침 동의 (필수)", false),
            ("위치정보 이용 동의 (선택)", false),
            ("마케팅 정보 수신 동의 (선택)", false)
        ]
        super.init(frame: .zero)
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateNextButton(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
        nextButton.backgroundColor = isEnabled ? CFColor.Primary.blue01 : CFColor.Bg.gray03
        nextButton.setTitleColor(isEnabled ? .white : CFColor.black04, for: .normal)
    }
    
    @objc private func checkButtonTappedFromCell(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? TermsTableViewCell,
              let indexPath = tableView.indexPath(for: cell) else { return }
        
        terms[indexPath.row].1.toggle()
        tableView.reloadRows(at: [indexPath], with: .none)
        
        let allSelected = terms.allSatisfy { $0.1 }
        allSelectButton.tintColor = allSelected ? CFColor.Primary.blue01 : CFColor.black02
        updateNextButton(isEnabled: terms[0...2].allSatisfy { $0.1 })
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
        
        nextButton.isEnabled = false
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.terms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TermsCell", for: indexPath) as? TermsTableViewCell else {
            return UITableViewCell()
        }
        let term = self.terms[indexPath.row]
        cell.configure(with: term.0, isSelected: term.1)
        cell.checkButton.addTarget(self, action: #selector(checkButtonTappedFromCell(_:)), for: .touchUpInside)
        return cell
    }
}
