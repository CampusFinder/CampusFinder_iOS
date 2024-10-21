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
    let writingButton = CFButton.writingButton(title: "구인 글쓰기")
    
    var categoryType: String
    
    private lazy var viewControllers: [UIViewController] = {
        return FinderCase.allCases.map { FindCampusTableViewController(category: $0, categoryType: categoryType) }
    }()
    
    init(categoryType: String) {
        self.categoryType = categoryType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        let currentCase = writingButton.titleLabel?.text
        
        if currentCase == "구인 글쓰기" {
            let vc = WritePortfolioViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = WriteRequestViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension FindCampusViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        let currentCategory = FinderCase.allCases[index]
        
        switch currentCategory {
        case .student:
            writingButton.setTitle("구인 글쓰기", for: .normal)
        case .request:
            writingButton.setTitle("의뢰 글쓰기", for: .normal)
        }
        
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = FinderCase.allCases[index].rawValue
        return TMBarItem(title: title)
    }
}
