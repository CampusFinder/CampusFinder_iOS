//
//  HomeViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 8/11/24.
//

import UIKit
import RxSwift

final class HomeViewController: BaseViewController {
    deinit {
        print("deinit: \(self)")
    }
    
    private let homeView = HomeView()
    
    let itemImages = ["designIcon",
                      "documentIcon",
                      "devIcon",
                      "videoIcon",
                      "foreignIcon",
                      "etcIcon"
    ]
    let itemLabels = ["디자인",
                      "문서작성",
                      "개발",
                      "영상",
                      "외국어",
                      "기타"
    ]
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        
        homeView.professorButton.addTarget(self, action: #selector(professorButtonClicked), for: .touchUpInside)
        
        homeView.findCollectionView.delegate = self
        homeView.findCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func searchButtonClicked() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func professorButtonClicked() {
        let vc = ProfessorViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FindCollectionViewCell.id, for: indexPath) as? FindCollectionViewCell else {
            return UICollectionViewCell()
        }
        let imageName = itemImages[indexPath.item]
        cell.itemImageView.image = UIImage(named: imageName)
        let labelText = itemLabels[indexPath.item]
        cell.itemLabel.text = labelText
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = itemLabels[indexPath.row]
        let categoryType = convertToCategoryType(selectedCategory)
        let vc = FindCampusViewController(categoryType: categoryType)
        vc.navigationItem.title = selectedCategory
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = 30
        let width = (Int(collectionView.bounds.width) - totalSpacing) / 3
        return CGSize(width: width, height: width)
    }
    
    private func convertToCategoryType(_ category: String) -> String {
        switch category {
        case "디자인":
            return "DESIGN"
        case "문서작성":
            return "DOCS"
        case "개발":
            return "DEV"
        case "영상":
            return "VIDEO"
        case "외국어":
            return "LANGUAGE"
        case "기타":
            return "ETC"
        default:
            return "ETC"
        }
    }
}
