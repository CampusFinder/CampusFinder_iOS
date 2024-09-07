//
//  WritePortfolioViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 9/5/24.
//

import UIKit

final class WritePortfolioViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let writePortfolioView = WritePortfolioView()
    
    override func loadView() {
        self.view = writePortfolioView
    }
    
    override func configureNavigation() {
        navigationItem.title = "구인 글쓰기"
    }
}
