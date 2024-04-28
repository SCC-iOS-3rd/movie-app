///
/// MovieListVC.swift
///N2FLIX
///
///Created by 송정훈 on 4/23/24.
///

import UIKit

class MovieListVC: UIViewController {
    var movieAPI = APIDatamanager()
    
    @IBAction func searchBtn(_ sender: Any) {
        let searchVC = UIStoryboard(name: "SearchStoryboard", bundle: nil)
            .instantiateViewController(withIdentifier: "SearchStoryboard") as? SearchViewController
        present(searchVC!,animated: true)
        //        self.navigationController?.pushViewController(searchVC!, animated: true)
    }
    @IBAction func MyPageBtn(_ sender: Any) {
        let myPageVC = UIStoryboard(name: "MyPage", bundle: nil)
            .instantiateViewController(withIdentifier: "MyPage") as? MyPageViewController
        myPageVC?.modalPresentationStyle = .fullScreen
        present(myPageVC!,animated: false)
    }
    let categories: [String] = ["popular", "now_playing", "top_rated", "adults"]
    var movieList: [String : [Result]] = ["now_playing" : [], "popular" : [], "top_rated" : [], "upcoming" : []]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tableView.separatorStyle = .none
        
    }
    //타이틀 이름 한국어로 바꾸기
    func koName(_ name : String) -> String {
        switch name {
        case "now_playing" :
            return "지금 상영중이에요"
        case "popular" :
            return "오늘의 TOP 5 영화"
        case "top_rated" :
            return "취향저격 베스트 영화"
        case "adults" :
            return "우린 당당하니까..🔞"
        default:
            return "분류.."
        }
    }
}


extension MovieListVC : UITableViewDataSource,UITableViewDelegate {
    //테이블 뷰 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    //테이블 뷰 cell설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.detaildelegate = self
        cell.titleLbl.text = koName(categories[indexPath.row])
        if categories[indexPath.row] == "adults" {
            movieAPI.readAPI(word: categories[indexPath.row], forSearch: true, type: [Result].self) {Movies in
                self.movieList[self.categories[indexPath.row]] = Movies
                for i in Movies {
                    cell.image.append(i.posterPath)
                    cell.id.append(i.id)
                }
                DispatchQueue.main.async {
                    cell.collectionView.reloadData()
                }
            }
        }else {
            
            if indexPath.row == 0 {
                cell.popularchk = true
            }
            movieAPI.readAPI(word: categories[indexPath.row], forSearch: false, type: [Result].self) {Movies in
                self.movieList[self.categories[indexPath.row]] = Movies
                for i in Movies {
                    cell.image.append(i.posterPath)
                    cell.id.append(i.id)
                }
                DispatchQueue.main.async {
                    cell.collectionView.reloadData()
                }
            }
            
        }
        
        return cell
    }
    //테이블뷰 높이 조정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 312
        } else {
            return 188
        }
    }
}

extension MovieListVC : MovieDetail {
    func detailPresent(_ index: Int) {
        let movieDetailVC = MovieDetailVC()
        movieDetailVC.id = index
        present(movieDetailVC, animated: true)
        
    }
}
