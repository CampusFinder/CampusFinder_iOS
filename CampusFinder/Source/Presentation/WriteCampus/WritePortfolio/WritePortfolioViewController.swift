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
        
        writePortfolioView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
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
        
        // 텍스트 필드와 텍스트뷰 바인딩 추가
        writePortfolioView.titleTextField.addTarget(self, action: #selector(titleDidChange), for: .editingChanged)
        
        // 텍스트뷰 델리게이트 설정
        writePortfolioView.questDetailTextView.delegate = self
    }
    
    @objc private func titleDidChange() {
        viewModel.title = writePortfolioView.titleTextField.text ?? ""
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
    
    @objc private func completeButtonTapped() {
        // 현재 텍스트뷰의 내용을 뷰모델에 저장
        viewModel.content = writePortfolioView.questDetailTextView.text
        
        // 입력값 검증
        let validation = viewModel.validateInputs()
        if !validation.isValid {
            // 에러 메시지 표시
            let alert = UIAlertController(title: "알림", message: validation.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
            return
        }
        
        // API 호출
        viewModel.writePortfolio { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    // 성공 처리
                    let alert = UIAlertController(title: "성공", message: "포트폴리오가 등록되었습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
                        self?.navigationController?.popViewController(animated: true)
                    })
                    self?.present(alert, animated: true)
                    
                case .failure(let error):
                    // 실패 처리
                    let alert = UIAlertController(title: "오류", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}

extension WritePortfolioViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.content = textView.text
        writePortfolioView.textViewDidChange(textView)
    }
}
