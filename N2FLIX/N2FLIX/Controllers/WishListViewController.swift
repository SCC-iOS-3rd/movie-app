//
//  WishListViewController.swift
//  N2FLIX
//
//  Created by Jeong-bok Lee on 4/24/24.
//

import UIKit

class WishListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var wishListMovies: [Movie] = []
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           collectionView.dataSource = self
           collectionView.delegate = self
           
           // 셀 등록
           collectionView.register(UINib(nibName: "WishListCell", bundle: nil), forCellWithReuseIdentifier: "WishListCell")
           
           // 위시리스트 영화 가져오기
           fetchWishListMovies()
           
           // 더미 데이터 추가 (임시)
           addDummyData()
           
           // 뒤로 가기 버튼 설정
           setupBackButton()
       }
       
       private func fetchWishListMovies() {
           // UserData.shared.wishList를 사용하여 실제 데이터를 가져오는 것으로 대체되어야 함
           wishListMovies = UserData.shared.wishList
           collectionView.reloadData()
       }
       
       private func addDummyData() {
           // 임의의 더미 데이터 추가
           let dummyMovie1 = Movie(title: "Dummy Movie 1", director: "Dummy Director 1", releaseYear: 2023)
           let dummyMovie2 = Movie(title: "Dummy Movie 2", director: "Dummy Director 2", releaseYear: 2022)
           
           wishListMovies.append(dummyMovie1)
           wishListMovies.append(dummyMovie2)
       }
       
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
       
       @objc private func backButtonTapped() {
           dismiss(animated: true, completion: nil)
       }
       
       // MARK: - UICollectionViewDataSource
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return wishListMovies.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishListCell", for: indexPath) as! WishListCollectionViewCell
           
           let movie = wishListMovies[indexPath.item]
           cell.configure(with: movie)
           
           return cell
       }
   }
