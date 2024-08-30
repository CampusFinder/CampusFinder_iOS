//
//  FindCampusViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 8/30/24.
//

import UIKit
import SnapKit
import Tabman
import Pageboy

final class FindCampusViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    var containerView = UIView()
    let tabManVC = TabmanViewController()
    
    let categories = ["학생찾기", "의뢰찾기"]
    
    private lazy var viewControllers: [UIViewController] = {
        return CategoryCase.allCases.map { FindCampusTableViewController(category: $0) }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabMan()
    }
    
    private func configureTabMan() {
        tabManVC.dataSource = self
        
        let barView = UIView()
        barView.backgroundColor = CFColor.Bg.gray01
        
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .custom(view: barView)
        bar.layout.transitionStyle = .snap
        bar.buttons.customize { button in
            button.tintColor = CFColor.black03
            button.selectedTintColor = CFColor.Primary.blue01
        }
        bar.indicator.tintColor = CFColor.Primary.blue01
        bar.layout.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 10)
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        tabManVC.addBar(bar, dataSource: self, at: .top)
    }
    
    override func configureHierarchy() {
        view.addSubview(containerView)
        containerView.addSubview(tabManVC.view)
        addChild(tabManVC)
        tabManVC.didMove(toParent: self)
    }
    
    override func configureConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tabManVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension FindCampusViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
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
