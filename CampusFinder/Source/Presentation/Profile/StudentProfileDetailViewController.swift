//
//  StudentProfileViewController.swift
//  CampusFinder
//
//  Created by 이빈 on 12/7/24.
//

import UIKit
import SnapKit
import Then

final class StudentProfileDetailViewController: BaseViewController {
    
    private let profileImageView = UIImageView()
    private let cameraButton = UIButton()
    private let nicknameLabel = UILabel()
    private let nicknameTextField = UITextField()
    private let introductionLabel = UILabel()
    private let introductionTextView = UITextView()
    
    private var isEditingProfile = false {
        didSet {
            updateUIForEditingState()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureView()
        configureHierarchy()
        configureConstraints()
    }
    
    override func configureNavigation() {
        title = "프로필"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "profileEdit"), style: .plain, target: self, action: #selector(editButtonTapped))
    }
    
    override func configureView() {
        profileImageView.do {
            $0.backgroundColor = .systemGray5
            $0.layer.cornerRadius = 60
            $0.clipsToBounds = true
        }
        
        cameraButton.do {
            $0.setImage(UIImage(named: "imageEdit"), for: .normal)
            $0.isHidden = !isEditingProfile
            $0.addTarget(self, action: #selector(selectImageFromGallery), for: .touchUpInside)
        }
        
        nicknameLabel.do {
            $0.text = "닉네임"
            $0.font = .pretendard(size: 18, weight: .semibold)
        }
        
        nicknameTextField.do {
            $0.text = "Vicky"
            $0.backgroundColor = .white
            $0.font = .pretendard(size: 16, weight: .semibold)
            $0.layer.cornerRadius = 12
            $0.layer.borderColor = UIColor.systemGray6.cgColor
            $0.layer.borderWidth = 1
            $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
            $0.leftViewMode = .always
            $0.delegate = self
        }
        
        introductionLabel.do {
            $0.text = "한 줄 소개"
            $0.font = .pretendard(size: 18, weight: .semibold)
        }
        
        introductionTextView.do {
            $0.text = """
            언제나 성실히 노력하는 씽씽입니다.
            많은 의뢰 부탁드립니다.
            """
            $0.backgroundColor = .white
            $0.font = .pretendard(size: 16, weight: .semibold)
            $0.layer.cornerRadius = 12
            $0.layer.borderColor = UIColor.systemGray6.cgColor
            $0.layer.borderWidth = 1
            $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            $0.delegate = self
        }
        
    }
    
    override func configureHierarchy() {
        
        [
            profileImageView,
            cameraButton,
            nicknameLabel,
            nicknameTextField,
            introductionLabel,
            introductionTextView
        ].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.width.height.equalTo(125)
            $0.centerX.equalToSuperview()
        }
        
        cameraButton.snp.makeConstraints {
            $0.trailing.equalTo(profileImageView.snp.trailing)
            $0.bottom.equalTo(profileImageView.snp.bottom)
            $0.width.height.equalTo(30)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(53)
        }
        
        introductionLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        
        introductionTextView.snp.makeConstraints {
            $0.top.equalTo(introductionLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(74)
        }
    }
    
    @objc func editButtonTapped() {
        isEditingProfile = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonTapped))
    }
    
    @objc func doneButtonTapped() {
        isEditingProfile = false
        print("done")
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateUIForEditingState() {
        cameraButton.isHidden = !isEditingProfile
    }
    
}

extension StudentProfileDetailViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // true를 반환하면 편집 가능, false를 반환하면 편집 비활성화
        return isEditingProfile // 편집을 비활성화
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return isEditingProfile
    }
}

extension StudentProfileDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func selectImageFromGallery() {
        guard isEditingProfile else { return }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            profileImageView.image = editedImage // 프로필 이미지 설정
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileImageView.image = originalImage
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}