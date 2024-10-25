//
//  CFAddPhotoView.swift
//  CampusFinder
//
//  Created by 강석호 on 9/8/24.
//

import UIKit
import SnapKit

class CFAddPhotoView: BaseView {
    private let addPhotoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let addPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "addPhoto")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let photoCountLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(size: 14, weight: .regular)
        label.textColor = CFColor.black03
        label.textAlignment = .center
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private var selectedImages: [UIImage] = [] {
        didSet {
            photoCountLabel.text = "\(selectedImages.count)/6"
        }
    }
    weak var viewController: UIViewController?
    
    override func configureHierarchy() {
        addSubview(collectionView)
        addSubview(addPhotoButton)
        addPhotoButton.addSubview(addPhotoImageView)
        addPhotoButton.addSubview(photoCountLabel)
    }
    
    override func configureUI() {
        setupCollectionView()
        photoCountLabel.text = "0/6"
        
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonTapped), for: .touchUpInside)
    }
    
    override func configureConstraints() {
        addPhotoButton.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        addPhotoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-6)
            make.size.equalTo(20)
        }
        
        photoCountLabel.snp.makeConstraints { make in
            make.top.equalTo(addPhotoImageView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalTo(addPhotoButton.snp.trailing).offset(8)
            make.top.bottom.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CFAddPhotoCollectionViewCell.self, forCellWithReuseIdentifier: CFAddPhotoCollectionViewCell.identifier)
    }
    
    @objc private func addPhotoButtonTapped() {
        guard selectedImages.count < 6 else {
            let alert = UIAlertController(title: "알림", message: "최대 6장까지만 선택할 수 있습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            viewController?.present(alert, animated: true)
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        viewController?.present(imagePicker, animated: true)
    }
    
    func getSelectedImages() -> [UIImage] {
        return selectedImages
    }
}

extension CFAddPhotoView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CFAddPhotoCollectionViewCell.identifier, for: indexPath) as? CFAddPhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: selectedImages[indexPath.item])
        
        cell.deleteButtonTapped = { [weak self] in
            guard let self = self else { return }
            
            // 인덱스가 유효한지 확인
            guard indexPath.item < self.selectedImages.count else { return }
            
            // selectedImages 배열에서 제거
            self.selectedImages.remove(at: indexPath.item)
            
            // CollectionView 전체 리로드
            collectionView.reloadData()
        }
        
        return cell
    }
}


extension CFAddPhotoView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImages.append(image)
            collectionView.reloadData()
        }
        picker.dismiss(animated: true)
    }
}
