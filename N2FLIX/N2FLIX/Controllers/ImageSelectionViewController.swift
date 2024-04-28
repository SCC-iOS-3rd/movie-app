//
//  ImageSelectionViewController.swift
//  N2FLIX
//
//  Created by Jeong-bok Lee on 4/26/24.
//

import UIKit
class ImageSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // 이미지 이름 배열
    let imageNames = (1...9).map { String(format: "ProfileImage/profileImage%02d", $0) }
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.9
        view.addSubview(blurEffectView)
        // 프로필 이미지 선택 안내 라벨 추가
            let infoLabel = UILabel(frame: CGRect(x: 0, y: 120, width: view.bounds.width, height: 40)) // 라벨의 높이와 y 좌표를 조정하여 텍스트 크기를 키우고 아래로 내림
            infoLabel.text = "프로필 이미지를 선택해주세요."
            infoLabel.textAlignment = .center
            infoLabel.textColor = .white
            infoLabel.font = UIFont.boldSystemFont(ofSize: 20) // 텍스트 크기를 키우기 위해 폰트 크기 조정
            view.addSubview(infoLabel)
            // 컬렉션 뷰 설정
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10) // 라벨을 고려하여 상단 여백 조정
            let collectionView = UICollectionView(frame: CGRect(x: 0, y: 250, width: view.bounds.width, height: view.bounds.height), collectionViewLayout: layout)
            collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.backgroundColor = .clear
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            view.addSubview(collectionView)
        }
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 10
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowRadius = 40
        let shadowRect = cell.bounds.insetBy(dx: -30, dy: -30)
        cell.layer.shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: cell.layer.cornerRadius).cgPath
        let imageView = UIImageView(image: UIImage(named: imageNames[indexPath.item]))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = cell.contentView.bounds
        cell.contentView.addSubview(imageView)
        return cell
    }
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 3) - 20
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImageName = imageNames[indexPath.item]
        NotificationCenter.default.post(name: .didSelectImage, object: selectedImageName)
        dismiss(animated: true, completion: nil) // 창 닫기
    }
}
