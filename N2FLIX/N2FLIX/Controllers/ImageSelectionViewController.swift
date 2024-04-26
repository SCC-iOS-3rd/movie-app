////
////  ImageSelectionViewController.swift
////  N2FLIX
////
////  Created by Jeong-bok Lee on 4/26/24.
////
//
//import UIKit
//
//class ImageSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    // 이미지 이름 배열
//    let imageNames = (1...9).map { String(format: "ProfileImage/profileImage%02d", $0) }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // 컬렉션 뷰 설정
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8) // 셀 사이의 간격 조절
//        
//        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
//        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.backgroundColor = .clear
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        view.addSubview(collectionView)
//    }
//    
//    // MARK: - UICollectionViewDataSource
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imageNames.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        cell.backgroundColor = .clear
//        cell.layer.cornerRadius = 10
//        cell.layer.shadowColor = UIColor.black.cgColor // 그림자 색상
//        cell.layer.shadowOffset = CGSize(width: 20, height: 20) // 그림자의 오프셋
//        cell.layer.shadowOpacity = 0.9 // 그림자의 투명도
//        cell.layer.shadowRadius = 20 // 그림자의 반경
//        let shadowRect = cell.bounds.insetBy(dx: -30, dy: -30)
//        cell.layer.shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: cell.layer.cornerRadius).cgPath
//        
//        let imageView = UIImageView(image: UIImage(named: imageNames[indexPath.item]))
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.frame = cell.contentView.bounds
//        cell.contentView.addSubview(imageView)
//        return cell
//    }
//
//    // MARK: - UICollectionViewDelegateFlowLayout
//
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (collectionView.frame.width / 3) - 20
//        return CGSize(width: width, height: width)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
//
//    // MARK: - UICollectionViewDelegate
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedImageName = imageNames[indexPath.item]
//        NotificationCenter.default.post(name: .didSelectImage, object: selectedImageName)
//        dismiss(animated: true, completion: nil) // 창 닫기
//    }
//}
