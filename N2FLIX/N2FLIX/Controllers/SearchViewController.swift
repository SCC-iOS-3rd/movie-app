//
//  SearchViewController.swift
//  N2FLIX
//
//  Created by SAMSUNG on 2024/04/22.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource {
    
    private var movies = [Movie] = []

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var searchPlaceholderLabel: UILabel!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMovie(searchTerm: "")
        
        searchPlaceholderLabel.text = "이런 영화는 어때요?"
        searchCollectionView.dataSource = self
        searchCollectionView.register(UINib(nibName: "SearchCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "SearchCollectionViewCell")
    }
    func fetchMovie(searchTerm: String) {
        self.movies = movies
        self.searchCollectionView.reloadData()
    }
    //뒤로가기 버튼
    @IBAction func tappedBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
//검색바에 관련한 동작
extension SearchViewController: UISearchBarDelegate {
    private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false
        else { return }
        
        print("검색결과: \(searchTerm)")
        //검색란 틀릭 시 문구 숨김
        searchPlaceholderLabel.isHidden = true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchPlaceholderLabel.isHidden = !searchText.isEmpty
    }
}
//컬렉션뷰 셀
class SearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var searchTitleLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            if let movie = movie {
                self.searchImageView.image = movie.image
                self.searchTitleLabel.text = movie.title
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
