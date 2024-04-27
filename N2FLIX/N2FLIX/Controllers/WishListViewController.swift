////
////  WishListViewController.swift
////  N2FLIX
////
////  Created by Jeong-bok Lee on 4/24/24.
////

import UIKit

class WishListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var CDM = CoreDataManager()
    var APIData = APIDatamanager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CollectionView 설정
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "WishListCell", bundle: nil), forCellWithReuseIdentifier: "WishListCell")
        collectionView.collectionViewLayout = StackCollectionViewFlowLayout()
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CDM.readWish().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishListCell", for: indexPath) as! WishListCollectionViewCell
        let movie = CDM.readWish()[indexPath.item]
        APIData.readImage(movie.posterPath) { image in
            DispatchQueue.main.async {
                cell.movieTitleLabel.text = movie.title
                cell.movieImageView.image = UIImage(data: image)
            }
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let Detail = MovieDetailVC()
        Detail.id = CDM.readWish()[indexPath.row].id
        present(Detail, animated: true)
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
                CDM.deleteWish(num: indexPath.row)
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
