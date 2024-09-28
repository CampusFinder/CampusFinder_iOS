//
//  WritePortfolioViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 9/5/24.
//

import UIKit

final class WritePortfolioViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let writePortfolioView = WritePortfolioView()
    let viewModel = WritePortfolioViewModel()
    
    override func loadView() {
        self.view = writePortfolioView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    override func configureNavigation() {
        navigationItem.title = "구인 글쓰기"
    }
    
    override func configureTarget() {
        writePortfolioView.serviceButton.addTarget(self, action: #selector(showCategorySelection), for: .touchUpInside)
        
        writePortfolioView.faceToFaceButton.addTarget(self, action: #selector(selectFaceToFace), for: .touchUpInside)
        writePortfolioView.nonFaceToFaceButton.addTarget(self, action: #selector(selectNonFaceToFace), for: .touchUpInside)
        writePortfolioView.dontCareButton.addTarget(self, action: #selector(selectDontCare), for: .touchUpInside)
        
        writePortfolioView.residenceButton.addTarget(self, action: #selector(selectResidence), for: .touchUpInside)
        writePortfolioView.nonResidenceButton.addTarget(self, action: #selector(selectNonResidence), for: .touchUpInside)
    }
    
    private func bind() {
        viewModel.categoryDidChange = { [weak self] selectedCategory in
            self?.writePortfolioView.serviceView.selectCategoryLabel.text = selectedCategory ?? ""
        }
        
        viewModel.questMethodDidChange = { [weak self] selectedMethod in
            self?.updateQuestMethod(selectedMethod)
        }
        
        viewModel.nearSchoolDidChange = { [weak self] selectedNearSchool in
            self?.updateNearSchool(selectedNearSchool)
        }
    }
    
    private func updateQuestMethod(_ selectedMethod: WritePortfolioViewModel.QuestMethod?) {
        let buttons = [
            (writePortfolioView.faceToFaceButton, WritePortfolioViewModel.QuestMethod.faceToFace),
            (writePortfolioView.nonFaceToFaceButton, WritePortfolioViewModel.QuestMethod.nonFaceToFace),
            (writePortfolioView.dontCareButton, WritePortfolioViewModel.QuestMethod.dontCare)
        ]
        
        buttons.forEach { button, method in
            if method == selectedMethod {
                button.setTitleColor(CFColor.Primary.blue01, for: .normal)
                button.layer.borderColor = CFColor.Primary.blue03.cgColor
            } else {
                button.setTitleColor(CFColor.black03, for: .normal)
                button.layer.borderColor = CFColor.Bg.gray02.cgColor
            }
        }
    }
    
    private func updateNearSchool(_ selectedNearSchool: WritePortfolioViewModel.NearSchool?) {
        let buttons = [
            (writePortfolioView.residenceButton, WritePortfolioViewModel.NearSchool.residence),
            (writePortfolioView.nonResidenceButton, WritePortfolioViewModel.NearSchool.nonResidence)
        ]
        
        buttons.forEach { button, method in
            if method == selectedNearSchool {
                button.setTitleColor(CFColor.Primary.blue01, for: .normal)
                button.layer.borderColor = CFColor.Primary.blue03.cgColor
            } else {
                button.setTitleColor(CFColor.black03, for: .normal)
                button.layer.borderColor = CFColor.Bg.gray02.cgColor
            }
        }
    }
    
    @objc private func showCategorySelection() {
        let actionSheet = UIAlertController(title: "서비스 선택", message: nil, preferredStyle: .actionSheet)
        
        viewModel.categories.forEach { category in
            let action = UIAlertAction(title: category, style: .default) { [weak self] _ in
                self?.viewModel.selectCategory(category)
            }
            actionSheet.addAction(action)
        }
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc private func selectFaceToFace() {
        viewModel.selectQuestMethod(.faceToFace)
    }
    
    @objc private func selectNonFaceToFace() {
        viewModel.selectQuestMethod(.nonFaceToFace)
    }
    
    @objc private func selectDontCare() {
        viewModel.selectQuestMethod(.dontCare)
    }
    
    @objc private func selectResidence() {
        viewModel.selectNearSchool(.residence)
    }
    
    @objc private func selectNonResidence() {
        viewModel.selectNearSchool(.nonResidence)
    }
}
