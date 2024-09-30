//
//  ProfessorViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 9/30/24.
//

import UIKit
import SnapKit
import Tabman
import Pageboy

final class ProfessorViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    var containerView = UIView()
    let tabManVC = TabmanViewController()
    let writingButton = CFButton.writingButton(title: "의뢰 글쓰기")
    
    private lazy var viewControllers: [UIViewController] = {
        return CategoryCase.allCases.map { ProfessorTableViewController(category: $0) }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabMan()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    private func configureTabMan() {
        tabManVC.dataSource = self
        
        let barView = UIView()
        barView.backgroundColor = CFColor.Bg.gray01
        
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .custom(view: barView)
        bar.layout.transitionStyle = .snap
        bar.buttons.customize { button in
            button.font = .pretendard(size: 18, weight: .medium)
            button.tintColor = CFColor.black03
            button.selectedTintColor = CFColor.Primary.blue01
            button.selectedFont = .pretendard(size: 18, weight: .bold)
        }
        bar.indicator.tintColor = CFColor.Primary.blue01
        bar.layout.contentInset = UIEdgeInsets(top: 16, left: 14, bottom: 14, right: 14)
        bar.layout.alignment = .leading
        bar.layout.contentMode = .intrinsic
        tabManVC.addBar(bar, dataSource: self, at: .top)
    }
    
    override func configureHierarchy() {
        view.addSubview(containerView)
        containerView.addSubview(tabManVC.view)
        addChild(tabManVC)
        tabManVC.didMove(toParent: self)
        view.addSubview(writingButton)
    }
    
    override func configureConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tabManVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        writingButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(122)
            make.height.equalTo(56)
        }
    }
    
    override func configureTarget() {
        writingButton.addTarget(self, action: #selector(writingButtonClicked), for: .touchUpInside)
    }
    
    @objc func writingButtonClicked() {
        let vc = WriteRequestViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension ProfessorViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = CategoryCase.allCases[index].rawValue
        return TMBarItem(title: title)
    }
}
