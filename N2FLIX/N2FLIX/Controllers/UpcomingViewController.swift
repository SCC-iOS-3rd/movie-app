//
//  UpcomingViewController.swift
//  N2FLIX
//
//  Created by SAMSUNG on 2024/04/23.
//

import UIKit

class UpcomingViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
        }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCell", for: indexPath) as? UpcomingCell else { return UICollectionViewCell() }
        
        return cell
    }
    //withIdentifier: "전달할 컨트롤러 세그웨이 이름"
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.item]
        performSegue(withIdentifier: "", sender: selectedMovie)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
class UpcomingCell: UICollectionViewCell {
    @IBOutlet weak var upcomingImageView: UIImageView!
    @IBOutlet weak var upcomingSubImageView: UIImageView!
    @IBOutlet weak var upcomingDateLabel: UILabel!
    @IBOutlet weak var upcomingTitleLabel: UILabel!
    @IBOutlet weak var upcomingDetailLabel: UILabel!
    
    
    var movie: Movie? {
        didSet {
            if let movie = movie {
                self.upcomingImageView.image = movie.image
                self.upcomingSubImageView.image = movie.image
                self.upcomingDateLabel.text = "개봉일: \(movie.releaseDate)"
                self.upcomingTitleLabel.text = movie.title
                self.upcomingDetailLabel.text = "\(movie.overview)"

            }
        }
    }
}
