//
//  DetailRequestViewController.swift
//  CampusFinder
//
//  Created by 강석호 on 10/20/24.
//

import UIKit
import Kingfisher

final class DetailRequestViewController: BaseViewController {
    deinit {
        print("deinit \(self)")
    }
    
    let detailRequestView = DetailRequestView()
    private let boardIdx: Int
    private var detailData: DetailRequestPostResponse?
    private var images: [UIImage] = []
    
    init(boardIdx: Int) {
        self.boardIdx = boardIdx
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = detailRequestView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadDetailData()
    }
    
    private func setupCollectionView() {
        detailRequestView.imageCollectionView.delegate = self
        detailRequestView.imageCollectionView.dataSource = self
        detailRequestView.imageCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
    }
    
    private func loadDetailData() {
        RequestPostNetworkManager.shared.detailRequestPost(boardIdx: boardIdx) { [weak self] result in
            switch result {
            case .success(let response):
                self?.detailData = response.data
                self?.loadImages(from: response.data.imageUrls) {
                    DispatchQueue.main.async {
                        self?.updateUI()
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
        
        detailRequestView.titleLabel.text = data.title
        detailRequestView.questDetail.text = data.content
        detailRequestView.userName.text = data.nickname
        detailRequestView.priceLabel.text = "\(data.money)원"
        detailRequestView.deadLine.text = data.deadline
        
        // 프로필 이미지 설정
        if let profileURL = URL(string: data.profileImage ?? "") {
            detailRequestView.userImage.kf.setImage(
                with: profileURL,
                placeholder: UIImage(systemName: "person.circle.fill")
            )
        }
        
        // 진행 방식 설정
        switch data.meetingType {
        case "FACE_TO_FACE":
            detailRequestView.questMethod.text = "대면"
        case "NON_FACE_TO_FACE":
            detailRequestView.questMethod.text = "비대면"
        default:
            detailRequestView.questMethod.text = "상관없음"
        }
        
        // 카테고리 설정
        switch data.categoryType {
        case "DESIGN":
            detailRequestView.categoryLabel.text = "디자인"
        case "DOC":
            detailRequestView.categoryLabel.text = "문서작성"
        case "DEV":
            detailRequestView.categoryLabel.text = "개발"
        case "VIDEO":
            detailRequestView.categoryLabel.text = "영상"
        case "LANG":
            detailRequestView.categoryLabel.text = "외국어"
        default:
            detailRequestView.categoryLabel.text = "기타"
        }
        
        // 이미지 관련 UI 업데이트
        let hasImage = !data.imageUrls.isEmpty
        detailRequestView.updateLayoutBasedOnImageAvailability(hasImage)
        
        if hasImage {
            detailRequestView.pageControl.numberOfPages = images.count
            detailRequestView.pageControl.currentPage = 0
            detailRequestView.imageCollectionView.reloadData()
        }
    }
    
    private func loadImages(from urls: [String], completion: @escaping () -> Void) {
        let group = DispatchGroup()
        images.removeAll()
        
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
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension DetailRequestViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        
        let imageView: UIImageView
        if let existingImageView = cell.contentView.subviews.first as? UIImageView {
            imageView = existingImageView
        } else {
            imageView = UIImageView(frame: cell.contentView.bounds)
            imageView.contentMode = .scaleAspectFit
            cell.contentView.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        imageView.image = images[indexPath.item]
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        detailRequestView.pageControl.currentPage = page
    }
}
