////
////  WishListViewController.swift
////  N2FLIX
////
////  Created by Jeong-bok Lee on 4/24/24.
////
//
//import UIKit
//
//// 위시리스트 뷰 컨트롤러 클래스
//class WishListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
//    // 섹션당 아이템 수를 반환하는 함수
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return wishListMovies.count  // 위시리스트 영화의 수를 반환
//    }
//    
//    // 각 아이템에 대한 셀을 반환하는 함수
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishListCell", for: indexPath) as! WishListCollectionViewCell
//        let movie = wishListMovies[indexPath.row]
//        cell.configure(with: movie)
//        return cell
//    }
//    
//    // 컬렉션 뷰 아웃렛
//    @IBOutlet weak var collectionView: UICollectionView!
//  
//    // 컬렉션 뷰의 데이터 소스
//    var wishListMovies: [Movie] = []
//  
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    
//        // 컬렉션 뷰 설정
//        collectionView.dataSource = self
//        collectionView.delegate = self
//    
//        // 셀 등록
//        collectionView.register(UINib(nibName: "WishListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WishListCell")
//    
//        // 위시리스트 영화 가져오기
//        fetchWishListMovies()
//    
//        // 뒤로 가기 버튼 설정
//        setupBackButton()
//    }
//  
//    // UserDefaults에서 위시리스트 영화를 가져오는 함수
//    private func fetchWishListMovies() {
//        wishListMovies = UserData.shared.wishList // wishListMovies 대신 wishList 사용
//        collectionView.reloadData()
//    }
//  
//    // 뒤로 가기 버튼 설정 함수
//    private func setupBackButton() {
//        let backButtonImage = UIImage(named: "Icon/chevronBack_icon")
//        let backButton = UIButton(type: .custom)
//        backButton.setImage(backButtonImage, for: .normal)
//        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//        backButton.translatesAutoresizingMaskIntoConstraints = false
//    
//        view.addSubview(backButton)
//    
//        NSLayoutConstraint.activate([
//            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            backButton.widthAnchor.constraint(equalToConstant: 24),
//            backButton.heightAnchor.constraint(equalToConstant: 24)
//        ])
//    }
//  
//    // 뒤로 가기 버튼 액션
//    @objc func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
//  
//    // 위시리스트에서 영화를 제거하는 함수
//    func removeFromWishList(_ movieTitle: String) {
//        if let index = wishListMovies.firstIndex(where: { $0.title == movieTitle }) {
//            wishListMovies.remove(at: index)
//            UserData.shared.wishList = wishListMovies // UserData의 wishList 업데이트
//            collectionView.reloadData()
//        }
//    }
//}

import UIKit

class WishListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var wishListMovies: [Movie] = [] // 사용자의 위시리스트 영화를 저장할 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CollectionView 설정
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "WishListCell", bundle: nil), forCellWithReuseIdentifier: "WishListCell")
        collectionView.collectionViewLayout = StackCollectionViewFlowLayout()
        
        // 더미 데이터 추가
        addDummyData()
        
        // 뒤로 가기 버튼 설정
        setupBackButton()
        
        // 스와이프 제스처 등록
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGesture.direction = .up
        collectionView.addGestureRecognizer(swipeGesture)
        
        // 수평 스크롤 설정
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    // 더미 데이터
    private func addDummyData() {
        // 실제 데이터 연결을 위해 더미 데이터 대신 실제 데이터를 추가해야 합니다.
        let dummyMovie1 = Movie(title: "Dummy Movie 1", director: "Dummy Director 1", releaseYear: 2023)
        let dummyMovie2 = Movie(title: "Dummy Movie 2", director: "Dummy Director 2", releaseYear: 2022)
        wishListMovies.append(dummyMovie1)
        wishListMovies.append(dummyMovie2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishListMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishListCell", for: indexPath) as! WishListCollectionViewCell
        let movie = wishListMovies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }

    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 40, height: collectionView.bounds.height - 40)
    }
    
    // MARK: - Actions
    
    @objc func handleSwipe(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .ended:
            let point = gesture.location(in: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: point) {
                wishListMovies.remove(at: indexPath.item)
                collectionView.performBatchUpdates({
                    collectionView.deleteItems(at: [indexPath])
                }, completion: nil)
            }
        case .changed:
            let translation = gesture.translation(in: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) {
                let cell = collectionView.cellForItem(at: indexPath)!
                cell.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
            }
        default:
            break
        }
    }
    
    // 뒤로 가기 버튼 UI
    private func setupBackButton() {
        let backButtonImage = UIImage(named: "Icon/chevronBack_icon")
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    // 뒤로 가기 버튼이 탭되었을 때 호출됩니다.
    @objc private func backButtonTapped() {
        dismiss(animated: false, completion: nil)
    }
}

class StackCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let count = collectionView.numberOfItems(inSection: 0)
        
        guard count > 0 else { return }
        
        let contentWidth = collectionView.bounds.width
        let contentHeight = collectionView.bounds.height
        
        let cellWidth = contentWidth * 0.8
        let cellHeight = contentHeight * 0.8
        
        let xOffset = (contentWidth - cellWidth) / 2
        let yOffset = (contentHeight - cellHeight) / 2
        
        minimumLineSpacing = 20
        
        itemSize = CGSize(width: cellWidth, height: cellHeight)
        sectionInset = UIEdgeInsets(top: yOffset, left: xOffset, bottom: yOffset, right: xOffset)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        attributes?.forEach { attribute in
            let distance = collectionView!.bounds.midX - attribute.center.x
            let normalizedDistance = abs(distance) / (collectionView!.bounds.width / 2)
            let fade = 1 - normalizedDistance
            attribute.alpha = fade
            let scale = 1 - normalizedDistance * 0.3
            attribute.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
