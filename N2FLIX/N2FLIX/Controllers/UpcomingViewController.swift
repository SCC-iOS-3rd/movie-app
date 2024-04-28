////
////  UpcomingViewController.swift
////  N2FLIX
////
////  Created by SAMSUNG on 2024/04/23.
////

import UIKit

class UpcomingViewController: UIViewController, UICollectionViewDataSource {
    
    let dataManager = APIDatamanager()
    private var results = [Result]()
    
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCell", for: indexPath) as? UpcomingCell else { return UICollectionViewCell() }
        dataManager.readImage(results[indexPath.row].posterPath) {
            image in
            DispatchQueue.main.async {
                cell.upcomingImageView.image = UIImage(data: image)
                cell.upcomingSubImageView.image = UIImage(data: image)
            }
        }
        cell.upcomingTitleLabel.text = results[indexPath.row].title
        cell.upcomingDetailLabel.text = results[indexPath.row].overview
        cell.upcomingDateLabel.text = "개봉일: \(results[indexPath.row].releaseDate)"
        return cell
    }
    
    //upcoming정보만 받아오기
    func fetchUpcomingMovies() {
        dataManager.readAPI(word: "upcoming", forSearch: false, type: [Result].self) { movie in
            let sortedMovie = movie.sorted { $0.releaseDate > $1.releaseDate}
            self.results = sortedMovie
            DispatchQueue.main.async {
                self.upcomingCollectionView.reloadData()
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUpcomingMovies()
        upcomingCollectionView.dataSource = self
    }
}

//셀 정렬
extension UpcomingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let minimumSpacing: CGFloat = 1
        let blank: CGFloat = 1
        let width: CGFloat = (view.bounds.width - minimumSpacing*2 - blank*2) / 1
        let height: CGFloat = width * 10 / 7
        return CGSize(width: width, height: height)
    }
}

//상세페이지로 이동
extension UpcomingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetail = MovieDetailVC()
        let selectedMovie = results[indexPath.item]
        movieDetail.id = selectedMovie.id
        present(movieDetail, animated: true)
    }
}

class UpcomingCell: UICollectionViewCell {
    @IBOutlet weak var upcomingImageView: UIImageView!
    @IBOutlet weak var upcomingSubImageView: UIImageView!
    @IBOutlet weak var upcomingDateLabel: UILabel!
    @IBOutlet weak var upcomingTitleLabel: UILabel!
    @IBOutlet weak var upcomingDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
