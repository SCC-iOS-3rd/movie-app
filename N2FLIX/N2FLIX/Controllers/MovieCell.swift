//
//  MovieCell.swift
//  N2FLIX
//
//  Created by 송정훈 on 4/23/24.
//

import UIKit

class MovieCell: UITableViewCell {
    let M = APIDatamanager()
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var image : [String] = []
    var id : [Int] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "MovieCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionCell")
    }
}

extension MovieCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as! MovieCollectionCell
        M.readImage(self.image[indexPath.row]) {data in
            DispatchQueue.main.async {
                cell.poster.image = UIImage(data: data)
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if titleLbl.text == "인기순" {
            return CGSize(width: 160, height: 264)
        }else {
            return CGSize(width: 96, height: 140)
        }
        
    }
    //컬렉션 뷰 선택
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("click index=\(id[indexPath.row])")
//            let cell  = collectionView.cellForItem(at: indexPath) as! MovieCollectionCell
            
        }
}
