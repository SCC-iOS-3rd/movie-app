////
////  UpcomingViewController.swift
////  N2FLIX
////
////  Created by SAMSUNG on 2024/04/23.
////
//
//import UIKit
//
//class UpcomingViewController: UIViewController, UICollectionViewDataSource {
//    
//    let dataManager = APIDatamanager()
//    private var results = [Result]()
//    
//    @IBOutlet weak var upcomingCollectionView: UICollectionView!
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return results.count
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCell", for: indexPath) as? UpcomingCell else { return UICollectionViewCell() }
//        let result = results[indexPath.item]
//        cell.movie = result
//        return cell
//    }
//    //withIdentifier: "전달할 컨트롤러 세그웨이 이름"
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedMovie = results[indexPath.item]
//        performSegue(withIdentifier: "", sender: selectedMovie)
//    }
//    //upcomin정보만 받아오기
//    func fetchUpcomingMovies() {
//        print("연결")
//        dataManager.readAPI(word: "upcoming", forSearch: true)
//        DispatchQueue.main.async {
//            self.results = self.dataManager.Movie
//            self.upcomingCollectionView.reloadData()
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        fetchUpcomingMovies()
//        upcomingCollectionView.dataSource = self
//    }
//}
//class UpcomingCell: UICollectionViewCell {
//    @IBOutlet weak var upcomingImageView: UIImageView!
//    @IBOutlet weak var upcomingSubImageView: UIImageView!
//    @IBOutlet weak var upcomingDateLabel: UILabel!
//    @IBOutlet weak var upcomingTitleLabel: UILabel!
//    @IBOutlet weak var upcomingDetailLabel: UILabel!
//    
//    
//    //이미지 URL을 이미지로 변환
//    final private func urlToImage(myUrl: String) -> UIImage? {
//        guard !myUrl.isEmpty, let url = URL(string: myUrl) else {
//            return nil
//        }
//        do {
//            let data = try Data(contentsOf: url)
//            return UIImage(data: data)
//        } catch {
//            print("\(error)")
//            return nil
//        }
//    }
//    //정보 가져오기
//    var movie: Result? {
//        didSet {
//            if let movie = movie {
//                let posterUrl = movie.posterPath
//                let image = urlToImage(myUrl: posterUrl)
//                if let image = image {
//                    self.upcomingImageView.image = image
//                    self.upcomingSubImageView.image = image
//                }
//                self.upcomingDateLabel.text = "개봉일: \(movie.releaseDate)"
//                self.upcomingTitleLabel.text = movie.title
//                self.upcomingDetailLabel.text = "\(movie.overview)"
//            }
//        }
//    }
//}

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
    
    //취소버튼, 이전 페이지(메인페이지)로 돌아감
    @IBAction func cancelButton(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
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
