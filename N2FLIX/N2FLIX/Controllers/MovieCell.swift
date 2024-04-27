//
//  MovieCell.swift
//  N2FLIX
//
//  Created by 송정훈 on 4/23/24.
//

import UIKit
protocol MovieDetail {
    func detailPresent(_ index : Int)
}

class MovieCell: UITableViewCell{
    let MovieAPI = APIDatamanager()
    var detaildelegate : MovieDetail?
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var image : [String] = []
    var id : [Int] = []
    
    var popularchk : Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "MovieCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionCell")
    }
}

extension MovieCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //컬렉션 뷰 셀의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if titleLbl.text == "오늘의 TOP 5 영화" {
            return image.count - 15
        }else {
            return image.count
        }
    }
    
    //컬렉션뷰 cell 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as! MovieCollectionCell
        if indexPath.row < 5{
            cell.chk = indexPath.row
        }
        if cell.chk < 5 && self.popularchk == true{
            cell.rankimg.image = UIImage(named: "Numbers/Number_0\(indexPath.row + 1)")
        }
        MovieAPI.readImage(self.image[indexPath.row]) {data in
            DispatchQueue.main.async {
                cell.poster.image = UIImage(data: data)
            }
        }
        return cell
    }
    //컬렉션뷰 레이아웃
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if titleLbl.text == "오늘의 TOP 5 영화" {
            return CGSize(width: 160, height: 264)
        }else {
            return CGSize(width: 96, height: 140)
        }
        
    }
    //컬렉션 뷰 선택
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("click index=\(id[indexPath.row])")
//            let cell  = collectionView.cellForItem(at: indexPath) as! MovieCollectionCell
        if let detaildelegate = detaildelegate {
            detaildelegate.detailPresent(id[indexPath.row])
        }
        
    }
    //컬렉션 뷰 좌우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

