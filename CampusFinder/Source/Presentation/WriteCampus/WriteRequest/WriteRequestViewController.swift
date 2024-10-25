//
//  WriteRequestViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 9/5/24.
//

import UIKit
import SnapKit
import Photos

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
        
        writeRequestView.addPhotoView.viewController = self
        
        bind()
    }
    
    override func configureTarget() {
        writeRequestView.serviceButton.addTarget(self, action: #selector(showCategorySelection), for: .touchUpInside)
        
        writeRequestView.discussionButton.addTarget(self, action: #selector(selectDiscussion), for: .touchUpInside)
        
        writeRequestView.rightNowButton.addTarget(self, action: #selector(selectRightNow), for: .touchUpInside)
        
        writeRequestView.faceToFaceButton.addTarget(self, action: #selector(selectFaceToFace), for: .touchUpInside)
        writeRequestView.nonFaceToFaceButton.addTarget(self, action: #selector(selectNonFaceToFace), for: .touchUpInside)
        writeRequestView.dontCareButton.addTarget(self, action: #selector(selectDontCare), for: .touchUpInside)
        writeRequestView.deadlineButton.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        
        writeRequestView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        
        PHPhotoLibrary.requestAuthorization { [weak self] status in
                    switch status {
                    case .authorized, .limited:
                        print("Photo access granted")
                    case .denied, .restricted:
                        DispatchQueue.main.async {
                            self?.showPhotoAccessAlert()
                        }
                    case .notDetermined:
                        print("Photo access not determined")
                    @unknown default:
                        break
                    }
                }
    }
    
    private func showPhotoAccessAlert() {
            let alert = UIAlertController(
                title: "사진 접근 권한이 필요합니다",
                message: "설정에서 사진 접근 권한을 허용해주세요.",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "설정으로 이동", style: .default) { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            })
            
            alert.addAction(UIAlertAction(title: "취소", style: .cancel))
            
            present(alert, animated: true)
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
        
        viewModel.discussionDidChange = { [weak self] discussion in
            switch discussion {
            case .discussion:
                self?.writeRequestView.discussionButton.setImage(UIImage(named: "toggle2"), for: .normal)
            case .nonDiscussion:
                self?.writeRequestView.discussionButton.setImage(UIImage(named: "toggle"), for: .normal)
            }
        }
        
        viewModel.rightNowDidChange = { [weak self] rightNow in
            switch rightNow {
            case .rightNow:
                self?.writeRequestView.rightNowButton.setImage(UIImage(named: "toggle2"), for: .normal)
            case .nonRightNow:
                self?.writeRequestView.rightNowButton.setImage(UIImage(named: "toggle"), for: .normal)
            }
        }
        
        writeRequestView.titleTextField.addTarget(self, action: #selector(titleDidChange), for: .editingChanged)
        writeRequestView.requestDetailTextView.delegate = self
        writeRequestView.priceView.textField.addTarget(self, action: #selector(priceDidChange), for: .editingChanged)
    }
    
    @objc private func titleDidChange() {
        viewModel.title = writeRequestView.titleTextField.text ?? ""
    }
    
    @objc private func priceDidChange() {
        viewModel.money = Int(writeRequestView.priceView.textField.text ?? "0") ?? 0
    }
    
    @objc private func completeButtonTapped() {
        viewModel.content = writeRequestView.requestDetailTextView.text
        
        // 선택된 이미지들을 뷰모델에 전달
        viewModel.selectedImages = writeRequestView.addPhotoView.getSelectedImages()
        
        print("Selected Images Count: \(viewModel.selectedImages.count)")
        
        let validation = viewModel.validateInputs()
        if !validation.isValid {
            let alert = UIAlertController(title: "알림", message: validation.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
            return
        }
        
        viewModel.writeRequest { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    let alert = UIAlertController(title: "성공", message: "의뢰가 등록되었습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
                        self?.navigationController?.popViewController(animated: true)
                    })
                    self?.present(alert, animated: true)
                    
                case .failure(let error):
                    let alert = UIAlertController(title: "오류", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
        
        viewModel.selectedImages = writeRequestView.addPhotoView.getSelectedImages()
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
    
    @objc private func selectDiscussion() {
        viewModel.toggleDiscussion()
    }
    
    @objc private func selectRightNow() {
        viewModel.toggleRightNow()
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

extension WriteRequestViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.content = textView.text
        writeRequestView.textViewDidChange(textView)
    }
}
