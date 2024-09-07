//
//  WriteRequestViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 9/5/24.
//

import UIKit

final class WriteRequestViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let writeRequestView = WriteRequestView()
    
    override func loadView() {
        self.view = writeRequestView
    }
    
    override func configureNavigation() {
        navigationItem.title = "의뢰 글쓰기"
    }
}
