//
//  DetailPortfolioViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 8/30/24.
//

import UIKit
import Kingfisher

final class DetailPortfolioViewController: BaseViewController {
    
    let detailPortfolioView = DetailPortfolioView()
    private let boardIdx: Int
    private var detailData: DetailStudentPostResponse?
    private var images: [UIImage] = []
    private var currentImageIndex = 0
    
    init(boardIdx: Int) {
        self.boardIdx = boardIdx
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = detailPortfolioView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetailData()
    }
    
    private func loadDetailData() {
        StudentPostNetworkManager.shared.detailStudentPost(boardIdx: boardIdx) { [weak self] result in
            switch result {
            case .success(let response):
                self?.detailData = response.data
                self?.loadImages(from: response.data.imageUrls) {
                    DispatchQueue.main.async {
                        self?.updateUI()
                        self?.setupSwipeGestures()
                    }
                }
            case .failure(let error):
                print("Error fetching detail: \(error)")
                DispatchQueue.main.async {
                    self?.showErrorAlert(message: "데이터를 불러오는 데 실패했습니다. 다시 시도해 주세요.")
                }
            }
        }
    }
    
    private func updateUI() {
        guard let data = detailData else { return }
        
        detailPortfolioView.titleLabel.text = data.title
        detailPortfolioView.questDetail.text = data.content
        detailPortfolioView.userName.text = data.nickname
        
        switch data.meetingType {
        case "NONE_FACE_TO_FACE":
            detailPortfolioView.questMethod.text = "비대면"
        case "FACE_TO_FACE":
            detailPortfolioView.questMethod.text = "대면"
        default:
            detailPortfolioView.questMethod.text = "대면/비대면"
        }
        
        detailPortfolioView.isNearCampus.text = data.isNearCampus ? "거주중 입니다." : "거주중이 아닙니다."
        detailPortfolioView.categoryLabel.text = data.categoryType
        
        let hasImage = !data.imageUrls.isEmpty
        detailPortfolioView.updateLayoutBasedOnImageAvailability(hasImage)
        
        if hasImage {
            detailPortfolioView.pageControl.numberOfPages = images.count
            if !images.isEmpty {
                detailPortfolioView.imageView.image = images[0]
                detailPortfolioView.pageControl.currentPage = 0
                currentImageIndex = 0
            }
        }
    }
    
    private func loadImages(from urls: [String], completion: @escaping () -> Void) {
        let group = DispatchGroup()
        
        for urlString in urls {
            group.enter()
            if let url = URL(string: urlString) {
                KingfisherManager.shared.retrieveImage(with: url) { [weak self] result in
                    switch result {
                    case .success(let imageResult):
                        self?.images.append(imageResult.image)
                    case .failure(let error):
                        print("Failed to load image: \(error)")
                    }
                    group.leave()
                }
            } else {
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
    
    private func setupSwipeGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        detailPortfolioView.imageView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        detailPortfolioView.imageView.addGestureRecognizer(swipeRight)
        
        detailPortfolioView.imageView.isUserInteractionEnabled = true
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        guard !images.isEmpty else { return }
        
        let direction: UIPageViewController.NavigationDirection = gesture.direction == .left ? .forward : .reverse
        let nextIndex = direction == .forward ? (currentImageIndex + 1) % images.count : (currentImageIndex - 1 + images.count) % images.count
        
        transitionToImage(at: nextIndex, direction: direction)
    }
    
    private func transitionToImage(at index: Int, direction: UIPageViewController.NavigationDirection, animated: Bool = true) {
        guard index != currentImageIndex else { return }
        
        currentImageIndex = index
        
        if animated {
            let transition = CATransition()
            transition.type = .push
            transition.subtype = direction == .forward ? .fromRight : .fromLeft
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            detailPortfolioView.imageView.layer.add(transition, forKey: nil)
        }
        
        detailPortfolioView.imageView.image = images[currentImageIndex]
        detailPortfolioView.pageControl.currentPage = currentImageIndex
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
