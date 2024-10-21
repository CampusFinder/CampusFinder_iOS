//
//  DetailRequestViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 10/20/24.
//

import UIKit

final class DetailRequestViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let detailRequestView = DetailRequestView()
    
    override func loadView() {
        self.view = detailRequestView
    }
}
