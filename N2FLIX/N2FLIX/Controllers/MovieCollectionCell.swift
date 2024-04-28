//
//  MovieCollectionCell.swift
//  N2FLIX
//
//  Created by 송정훈 on 4/23/24.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {

    @IBOutlet weak var rankimg: UIImageView!
    @IBOutlet weak var poster: UIImageView!
    var chk : Int = 66
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        poster.layer.cornerRadius = 4
        poster.clipsToBounds = true
        

                
    }

}
