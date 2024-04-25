////
////  SearchViewController.swift
////  N2FLIX
////
////  Created by SAMSUNG on 2024/04/22.
////
//
//import UIKit
//
//class SearchViewController: UIViewController, UICollectionViewDataSource {
//    
//    let apiDataManager = APIDatamanager()
//    private var results = [Result]()
//    
//    @IBOutlet weak var searchBar: UISearchBar!
//    @IBOutlet weak var searchCollectionView: UICollectionView!
//    @IBOutlet weak var searchPlaceholderLabel: UILabel!
//    let searchController = UISearchController(searchResultsController: nil)
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return results.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
//        let result = results[indexPath.item]
//        cell.movie = result
//        return cell
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        fetchRecommendedMovies()
//        searchPlaceholderLabel.text = "이런 영화는 어때요?"
//        searchBar.delegate = self
//        searchCollectionView.dataSource = self
//    }
//    
//    //검색 결과 가져오기
//    func fetchSearchedMovies(for searchTerm: String) {
//        apiDataManager.readAPI(word: searchTerm, forSearch: true)
//        DispatchQueue.main.async {
//            self.results = self.apiDataManager.Movie
//            self.searchCollectionView.reloadData()
//        }
//    }
//    
//    //검색 전, 추천영화 뜨기
//    func fetchRecommendedMovies() {
//        apiDataManager.readAPI(word: "popular", forSearch: false)
//        DispatchQueue.main.async {
//            self.results = self.apiDataManager.Movie
//            self.searchCollectionView.reloadData()
//        }
//    }
//    
//    //검색 결과 날짜 순으로 정렬
//    func searchMovies(keyword: String) {
//        
//    }
//    
//    //뒤로가기 버튼
//    @IBAction func tappedBack(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
//    }
//}
//
////검색바에 관련한 동작
//extension SearchViewController: UISearchBarDelegate {
//    private func dismissKeyboard() {
//        searchBar.resignFirstResponder()
//    }
//    func SearchButtontapped(_ searchBar: UISearchBar) {
//        dismissKeyboard()
//        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
//        fetchSearchedMovies(for: searchTerm)
//    }
//    //검색시 문구 사라짐
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchPlaceholderLabel.isHidden = !searchText.isEmpty
//    }
//}
////컬렉션뷰 셀
//class SearchCollectionViewCell: UICollectionViewCell {
//    @IBOutlet weak var searchImageView: UIImageView!
//    @IBOutlet weak var searchTitleLabel: UILabel!
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
//    //이미지와 제목 정보 가져오기
//    var movie: Result? {
//        didSet {
//            if let movie = movie {
//                let posterUrl = movie.posterPath
//                let image = urlToImage(myUrl: posterUrl)
//                if let image = image {
//                    self.searchImageView.image = image
//                }
//                self.searchTitleLabel.text = movie.title
//            }
//        }
//    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//}
