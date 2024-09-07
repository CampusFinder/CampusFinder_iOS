//
//  DetailCampusViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 8/30/24.
//

import UIKit

final class DetailCampusViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let detailCampusView = DetailCampusView()
    
    override func loadView() {
        self.view = detailCampusView
    }
}
