//
//  WishListCollectionViewCell.swift
//  N2FLIX
//
//  Created by Jeong-bok Lee on 4/26/24.
//

import UIKit


class WishListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    
    func configure(with movie: Movie) {
        movieTitleLabel.text = movie.title
//        movieImageView.image = UIImage(named: movie.imageURL)
    }
}
