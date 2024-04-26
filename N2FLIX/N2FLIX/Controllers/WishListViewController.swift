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
