////
////  SearchViewController.swift
////  N2FLIX
////
////  Created by SAMSUNG on 2024/04/22.
////

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource {
    
    //검색 완료버튼
    @IBAction func searchButton(_ sender: Any) {
        SearchButtontapped(searchBar)
    }
    
    let apiDataManager = APIDatamanager()
    private var results = [Result]()
    private var searchActive = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var searchPlaceholderLabel: UILabel!
    @IBOutlet weak var noResultLabel: UILabel!
    
    let searchController = UISearchController(searchResultsController: nil)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        apiDataManager.readImage(results[indexPath.row].posterPath) {
            image in
            DispatchQueue.main.async {
                cell.searchImageView.image = UIImage(data: image)
            }
        }
        cell.searchTitleLabel.text = results[indexPath.row].title
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchRecommendedMovies()
        searchPlaceholderLabel.text = "이런 영화는 어때요?"
        searchCollectionView.dataSource = self
        searchBar.delegate = self
    }
    
    //검색 결과 가져오기
    func fetchSearchedMovies(for searchTerm: String) {
        apiDataManager.readAPI(word: searchTerm, forSearch: true, type: [Result].self) { movie in
            let sortedMovie = movie.sorted { $0.releaseDate > $1.releaseDate }
            self.results = sortedMovie
            DispatchQueue.main.async {
                if self.results.isEmpty {
                    self.noResultLabel.isHidden = false
                } else {
                    self.noResultLabel.isHidden = true
                }
                self.searchCollectionView.reloadData()
            }
        }
    }
    
    //검색 전, 추천영화 뜨기
    func fetchRecommendedMovies() {
            apiDataManager.readAPI(word: "popular", forSearch: false, type: [Result].self) { movie in
            self.results = movie
            DispatchQueue.main.async {
                self.noResultLabel.isHidden = true
                self.searchCollectionView.reloadData()
            }
        }
    }
    
    //뒤로가기 버튼
    @IBAction func tappedBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

//검색바에 관련한 동작
extension SearchViewController: UISearchBarDelegate {
 
    
    private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    func SearchButtontapped(_ searchBar: UISearchBar) {
        dismissKeyboard()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        fetchSearchedMovies(for: searchTerm)
    }
 
    //검색시 문구 사라짐
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchActive = !searchText.isEmpty
        if searchActive {
            results = []
            searchCollectionView.reloadData()
            searchPlaceholderLabel.isHidden = true
        } else if !searchActive && searchBar.text == "" {
            searchPlaceholderLabel.isHidden = true
        }
    }
}

//셀 정렬
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let minimumSpacing: CGFloat = 3
        let blank: CGFloat = 3
        let width: CGFloat = (view.bounds.width - minimumSpacing*2 - blank) / 3
        let height: CGFloat = width * 10 / 7
        return CGSize(width: width - 10, height: height)
    }
}

//상세페이지로 이동
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetail = MovieDetailVC()
        let selectedMovie = results[indexPath.item]
        movieDetail.id = selectedMovie.id
        present(movieDetail, animated: true)
    }
}

//컬렉션뷰 셀
class SearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var searchTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
