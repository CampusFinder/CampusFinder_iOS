//
//  SelectPositionViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 8/11/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SelectPositionViewController: BaseViewController {
    deinit {
        print("deinit: \(self)")
    }
    
    private let selectPositionView = SelectPositionView()
    
    override func loadView() {
        self.view = selectPositionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureTarget() {
        selectPositionView.selectStudentButton.addTarget(self, action: #selector(studentButtonClicked), for: .touchUpInside)
        
        selectPositionView.selectProfessorButton.addTarget(self, action: #selector(professorButtonClicked), for: .touchUpInside)
    }
    
    @objc func studentButtonClicked() {
        let vc = RoleCertifyViewController()
        vc.navigationItem.title = "학생 학력인증"
        navigationController?.pushViewController(vc, animated: true)
        SignupData.shared.role = "STUDENT"
    }
    
    @objc func professorButtonClicked() {
        let vc = RoleCertifyViewController()
        vc.navigationItem.title = "교수 인증"
        navigationController?.pushViewController(vc, animated: true)
        SignupData.shared.role = "PROFESSOR"
    }
}
