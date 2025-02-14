//
//  ProfProfileDetailViewController.swift
//  CampusFinder
//
//  Created by 이빈 on 12/13/24.
//

import UIKit
import SnapKit
import Then

final class ProfProfileDetailViewController: BaseViewController {
    
    private let profileImageView = UIImageView()
    private let cameraButton = UIButton()
    
    private let nicknameLabel = UILabel()
    private let nicknameTextField = UITextField()
    
    private let introductionLabel = UILabel()
    
    private let workDayView = UIView()
    private let workDayLabel = UILabel()
    private let days = ["월", "화", "수", "목", "금", "토", "일"]
    private var selectedDays: [String] = ["월", "금"] // 서버에서 받아 온 요일
    private var dayButtons: [UIButton] = []
    private let dayStackView = UIStackView()
    
    private let workTimeView = UIView()
    private let workTimeLabel = UILabel()
    private let startTime = UIDatePicker()
    private let tildeLabel = UILabel()
    private let endTime = UIDatePicker()
    
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
        updateDayButtonStates()
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
            $0.text = "업무요일 및 시간"
            $0.font = .pretendard(size: 18, weight: .semibold)
        }
        
        workDayView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 12
            $0.layer.borderColor = UIColor.systemGray6.cgColor
            $0.layer.borderWidth = 1
        }
        
        workDayLabel.do {
            $0.text = "업무요일"
            $0.font = .pretendard(size: 16, weight: .semibold)
        }
        
        dayStackView.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 8
        }
        
        //기존 버튼 초기화
        dayButtons.removeAll()
        dayStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        days.forEach { day in
            let button = UIButton(type: .system).then {
                $0.setTitle(day, for: .normal)
                $0.setTitleColor(.systemGray, for: .normal)
                $0.setTitleColor(.white, for: .selected)
                $0.backgroundColor = .clear
                $0.layer.cornerRadius = 8
                $0.layer.borderColor = UIColor.systemGray5.cgColor
                $0.layer.borderWidth = 1
                $0.isUserInteractionEnabled = isEditingProfile
                $0.addTarget(self, action: #selector(dayButtonTapped(_:)), for: .touchUpInside)
            }
            dayButtons.append(button)
            dayStackView.addArrangedSubview(button)
        }
        
        workTimeView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 12
            $0.layer.borderColor = UIColor.systemGray6.cgColor
            $0.layer.borderWidth = 1
        }
        
        workTimeLabel.do {
            $0.text = "업무시간"
            $0.font = .pretendard(size: 16, weight: .semibold)
        }
        
        startTime.do {
            $0.datePickerMode = .time
            $0.preferredDatePickerStyle = .compact
            $0.locale = Locale(identifier: "ko-KR")
            $0.minuteInterval = 10
            $0.isUserInteractionEnabled = isEditingProfile
            $0.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
        }
        
        tildeLabel.do {
            $0.text = "~"
            $0.font = .pretendard(size: 16, weight: .semibold)
        }
        
        endTime.do {
            $0.datePickerMode = .time
            $0.preferredDatePickerStyle = .compact
            $0.locale = Locale(identifier: "ko-KR")
            $0.minuteInterval = 10
            $0.isUserInteractionEnabled = isEditingProfile
            $0.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
        }
    }
    
    override func configureHierarchy() {
        
        [workDayLabel, dayStackView].forEach {
            workDayView.addSubview($0)
        }
        
        [workTimeLabel, startTime, tildeLabel, endTime].forEach {
            workTimeView.addSubview($0)
        }
        
        [
            profileImageView,
            cameraButton,
            nicknameLabel,
            nicknameTextField,
            introductionLabel,
            workDayView,
            workTimeView
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
        
        workDayView.snp.makeConstraints {
            $0.top.equalTo(introductionLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(53)
        }
        
        workDayLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        dayStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        workTimeView.snp.makeConstraints {
            $0.top.equalTo(workDayView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(53)
        }
        
        workTimeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        startTime.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(tildeLabel.snp.leading).offset(-5)
        }
        
        tildeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(endTime.snp.leading).offset(-5)
        }
        
        endTime.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
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
    
    @objc func dayButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        sender.backgroundColor = sender.isSelected ? .systemBlue : .clear
    }
    
    func updateUIForEditingState() {
        cameraButton.isHidden = !isEditingProfile
        dayButtons.forEach {
            $0.isUserInteractionEnabled = isEditingProfile
        }
        startTime.isUserInteractionEnabled = isEditingProfile
        endTime.isUserInteractionEnabled = isEditingProfile
    }
    
    func updateDayButtonStates() {
        for (index, button) in dayButtons.enumerated() {
            if selectedDays.contains(days[index]) {
                button.isSelected = true
                button.backgroundColor = .systemBlue
            } else {
                button.isSelected = false
                button.backgroundColor = .clear
            }
        }
    }
    
    @objc func handleDatePicker(_ sender: UIDatePicker) {
        print(sender)
    }
    
}

extension ProfProfileDetailViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // true를 반환하면 편집 가능, false를 반환하면 편집 비활성화
        return isEditingProfile // 편집을 비활성화
    }
}

extension ProfProfileDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
