//
//  DatePickerViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 9/28/24.
//

import UIKit
import SnapKit

final class DatePickerViewController: UIViewController {

    var dateSelected: ((Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.backgroundColor = .white

        view.addSubview(datePicker)

        datePicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(150)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(300)
        }

        
        let confirmButton = CFButton.primaryButton(title: "선택 완료")
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped(_:)), for: .touchUpInside)

        view.addSubview(confirmButton)

        confirmButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(datePicker.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
    }

    @objc private func confirmButtonTapped(_ sender: UIButton) {
        if let datePicker = view.subviews.first(where: { $0 is UIDatePicker }) as? UIDatePicker {
            dateSelected?(datePicker.date)
        }

        dismiss(animated: true, completion: nil)
    }
}
