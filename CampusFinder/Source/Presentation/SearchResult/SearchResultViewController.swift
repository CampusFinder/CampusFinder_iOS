//
//  SearchResultViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 9/23/24.
//

import UIKit
import SnapKit
import Tabman
import Pageboy

final class SearchResultViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    private let searchQuery: String
    let searchBar = CFSearchBar()
    
    var containerView = UIView()
    let tabManVC = TabmanViewController()
    
    private lazy var viewControllers: [UIViewController] = {
        return FinderCase.allCases.map { SearchResultTableViewController(category: $0) }
    }()
    
    init(searchQuery: String) {
        self.searchQuery = searchQuery
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("검색어 : \(searchQuery)")
        
        configureTabMan()
    }
    
    override func configureNavigation() {
        let searchBarContainer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 41))
        searchBarContainer.addSubview(searchBar)
        searchBarContainer.backgroundColor = .clear
        searchBar.frame = CGRect(x: 3, y: 0, width: 315, height: 41)
        navigationItem.titleView = searchBarContainer
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

extension SearchResultViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
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
        let title = FinderCase.allCases[index].rawValue
        return TMBarItem(title: title)
    }
}
