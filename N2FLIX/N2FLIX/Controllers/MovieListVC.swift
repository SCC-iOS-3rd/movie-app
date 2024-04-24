//
//  MovieListVC.swift
//  N2FLIX
//
//  Created by 송정훈 on 4/23/24.
//

import UIKit

class MovieListVC: UIViewController {
    var M = APIDatamanager()
    
    let categories: [String] = ["popular", "now_playing", "top_rated", "upcoming"]
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
    func koName(_ name : String) -> String {
        switch name {
        case "now_playing" :
            return "현재 상영중인 영화"
        case "popular" :
            return "인기순"
        case "top_rated" :
            return "현재 예매율 순위"
        default:
            return "분류.."
        }
    }
}


extension MovieListVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.titleLbl.text = koName(categories[indexPath.row])
        M.readAPI(categories[indexPath.row]) {Movies in
            self.movieList[self.categories[indexPath.row]] = Movies
            for i in Movies {
                cell.image.append(i.posterPath)
                cell.id.append(i.id)
            }
            DispatchQueue.main.async {
                cell.collectionView.reloadData()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 312
        } else {
            return 188
        }
    }
}
