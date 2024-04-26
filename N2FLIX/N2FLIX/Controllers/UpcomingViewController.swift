//
//  UpcomingViewController.swift
//  N2FLIX
//
//  Created by SAMSUNG on 2024/04/23.
//

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
        let result = results[indexPath.item]
        cell.movie = result
        return cell
    }
    //withIdentifier: "전달할 컨트롤러 세그웨이 이름"
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = results[indexPath.item]
        performSegue(withIdentifier: "", sender: selectedMovie)
    }
    //upcomin정보만 받아오기
    func fetchUpcomingMovies() {
        print("연결")
        dataManager.readAPI(word: "upcoming", forSearch: true)
        DispatchQueue.main.async {
            self.results = self.dataManager.Movie
            self.upcomingCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUpcomingMovies()
        upcomingCollectionView.dataSource = self
    }
}
class UpcomingCell: UICollectionViewCell {
    @IBOutlet weak var upcomingImageView: UIImageView!
    @IBOutlet weak var upcomingSubImageView: UIImageView!
    @IBOutlet weak var upcomingDateLabel: UILabel!
    @IBOutlet weak var upcomingTitleLabel: UILabel!
    @IBOutlet weak var upcomingDetailLabel: UILabel!
    
    
    //이미지 URL을 이미지로 변환
    final private func urlToImage(myUrl: String) -> UIImage? {
        guard !myUrl.isEmpty, let url = URL(string: myUrl) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        } catch {
            print("\(error)")
            return nil
        }
    }
    //정보 가져오기
    var movie: Result? {
        didSet {
            if let movie = movie {
                let posterUrl = movie.posterPath
                let image = urlToImage(myUrl: posterUrl)
                if let image = image {
                    self.upcomingImageView.image = image
                    self.upcomingSubImageView.image = image
                }
                self.upcomingDateLabel.text = "개봉일: \(movie.releaseDate)"
                self.upcomingTitleLabel.text = movie.title
                self.upcomingDetailLabel.text = "\(movie.overview)"
            }
        }
    }
}
