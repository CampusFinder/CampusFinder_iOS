//
//  WriteRequestViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 9/5/24.
//

import UIKit
import SnapKit

final class WriteRequestViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let writeRequestView = WriteRequestView()
    let viewModel = WriteRequestViewModel()
    
    override func loadView() {
        self.view = writeRequestView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    override func configureTarget() {
        writeRequestView.serviceButton.addTarget(self, action: #selector(showCategorySelection), for: .touchUpInside)
        
        writeRequestView.faceToFaceButton.addTarget(self, action: #selector(selectFaceToFace), for: .touchUpInside)
        writeRequestView.nonFaceToFaceButton.addTarget(self, action: #selector(selectNonFaceToFace), for: .touchUpInside)
        writeRequestView.dontCareButton.addTarget(self, action: #selector(selectDontCare), for: .touchUpInside)
        writeRequestView.deadlineButton.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
    }
    
    private func bind() {
        viewModel.categoryDidChange = { [weak self] selectedCategory in
            self?.writeRequestView.serviceView.selectCategoryLabel.text = selectedCategory ?? ""
        }
        
        viewModel.questMethodDidChange = { [weak self] selectedMethod in
            self?.updateQuestMethod(selectedMethod)
        }
        
        viewModel.deadlineDidChange = { [weak self] selectedDeadline in
            self?.writeRequestView.deadlineView.selectCategoryLabel.text = selectedDeadline ?? ""
        }
    }
    
    private func updateQuestMethod(_ selectedMethod: WriteRequestViewModel.QuestMethod?) {
        let buttons = [
            (writeRequestView.faceToFaceButton, WriteRequestViewModel.QuestMethod.faceToFace),
            (writeRequestView.nonFaceToFaceButton, WriteRequestViewModel.QuestMethod.nonFaceToFace),
            (writeRequestView.dontCareButton, WriteRequestViewModel.QuestMethod.dontCare)
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
    
    @objc private func showDatePicker() {
        let datePickerVC = DatePickerViewController()
        
        datePickerVC.dateSelected = { [weak self] selectedDate in
            self?.viewModel.selectDeadline(selectedDate)
        }

        if let sheet = datePickerVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        
        self.present(datePickerVC, animated: true, completion: nil)
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
    
    override func configureNavigation() {
        navigationItem.title = "의뢰 글쓰기"
    }
}
