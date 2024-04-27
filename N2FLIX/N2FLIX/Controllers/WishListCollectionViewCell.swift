//
//  WishListCollectionViewCell.swift
//  N2FLIX
//
//  Created by Jeong-bok Lee on 4/26/24.
//

import UIKit


class WishListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
           super.awakeFromNib()
           
           
       }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("coder: aDecoder")
        // 그림자 추가
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 36
        layer.masksToBounds = true
        
        // 셀의 모서리 둥글게
        layer.cornerRadius = 30
        
    }
    
}
