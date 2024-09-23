//
//  SearchResultViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 9/23/24.
//

import UIKit
import SnapKit

final class SearchResultViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    private let searchQuery: String
    
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
    }
    
}
