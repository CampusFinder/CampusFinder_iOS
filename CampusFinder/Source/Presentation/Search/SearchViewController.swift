//
//  SearchViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 9/22/24.
//

import UIKit

final class SearchViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    private let searchView = SearchView()
    let searchBar = CFSearchBar()
    
    var recentKeywords: [String] = []
    
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchTextField()
        configureCollectionView()
        loadRecentKeywords()
    }
    
    override func configureTarget() {
        searchView.allDeleteButton.addTarget(self, action: #selector(deleteAllKeywords), for: .touchUpInside)
    }
    
    override func configureNavigation() {
        let searchBarContainer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 41))
        searchBarContainer.addSubview(searchBar)
        searchBarContainer.backgroundColor = .clear
        searchBar.frame = CGRect(x: 3, y: 0, width: 315, height: 41)
        navigationItem.titleView = searchBarContainer
    }
    
    private func configureCollectionView() {
        searchView.recentKeywordCollectionView.dataSource = self
        searchView.recentKeywordCollectionView.delegate = self
        searchView.recentKeywordCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setupSearchTextField() {
        searchBar.searchTextField.delegate = self
    }
    
    //MARK: UserDefaults에서 최근 검색어 조회
    private func loadRecentKeywords() {
        recentKeywords = UserDefaultsManager.shared.loadRecentKeywords()
        searchView.recentKeywordCollectionView.reloadData()
    }
    
    //MARK: 모든 최근 검색어 삭제
    @objc private func deleteAllKeywords() {
        UserDefaultsManager.shared.deleteAllRecentKeywords()
        recentKeywords.removeAll()
        searchView.recentKeywordCollectionView.reloadData()
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let searchText = textField.text, !searchText.isEmpty else {
            return false
        }
        
        UserDefaultsManager.shared.saveRecentKeyword(searchText)
        
        loadRecentKeywords()
        
        textField.text = ""
        
        let vc = SearchResultViewController(searchQuery: searchText)
        navigationController?.pushViewController(vc, animated: true)
        
        textField.resignFirstResponder()
        return true
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentKeywords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentKeywordCell.identifier, for: indexPath) as! RecentKeywordCell
        
        let keyword = recentKeywords[indexPath.row]
        cell.configure(with: keyword)
        
        cell.deleteButtonTapped = { [weak self] in
            guard let self = self else { return }
            UserDefaultsManager.shared.deleteRecentKeyword(keyword)
            self.loadRecentKeywords()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let keyword = recentKeywords[indexPath.row]
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = keyword
        label.sizeToFit()
        
        let labelWidth = label.frame.width
        let totalWidth = labelWidth + 8 + 5 + 12 + 9
        
        return CGSize(width: totalWidth, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedKeyword = recentKeywords[indexPath.row]
        
        let vc = SearchResultViewController(searchQuery: selectedKeyword)
        navigationController?.pushViewController(vc, animated: true)
    }
}
