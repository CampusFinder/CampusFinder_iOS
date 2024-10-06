//
//  TermsViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 8/11/24.
//

import UIKit

final class TermsViewController: BaseViewController {
    deinit {
        print("deinit: \(self)")
    }
    
    private let termsView = TermsView()
        
    override func loadView() {
        self.view = termsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNextButtonState()
    }
    
    override func configureTarget() {
        termsView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        termsView.allSelectButton.addTarget(self, action: #selector(selectAllButtonTapped), for: .touchUpInside)
    }
    
    @objc private func nextButtonClicked() {
        let vc = SelectPositionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func selectAllButtonTapped() {
        let newSelectionState = !termsView.terms.allSatisfy { $0.1 }
        termsView.terms = termsView.terms.map { ($0.0, newSelectionState) }
        termsView.tableView.reloadData()
        
        updateAllSelectButtonState()
        updateNextButtonState()
    }
    
    @objc private func checkButtonTapped(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? TermsTableViewCell,
              let indexPath = termsView.tableView.indexPath(for: cell) else { return }
        
        termsView.terms[indexPath.row].1.toggle()
        termsView.tableView.reloadRows(at: [indexPath], with: .none)
        
        updateAllSelectButtonState()
        updateNextButtonState()
    }
    
    private func updateAllSelectButtonState() {
        let allSelected = termsView.terms.allSatisfy { $0.1 }
        termsView.allSelectButton.tintColor = allSelected ? CFColor.Primary.blue01 : CFColor.black02
    }
    
    private func updateNextButtonState() {
        let requiredSelections = termsView.terms[0...2].allSatisfy { $0.1 }
        termsView.updateNextButton(isEnabled: requiredSelections)
    }
}
