//
//  WishListViewController.swift
//  N2FLIX
//
//  Created by Jeong-bok Lee on 4/24/24.
//

import UIKit

struct Movie {
    let title: String
    let director: String
    let releaseYear: Int
    // 필요에 따라 다른 속성 추가 가능
}

class WishListViewController: UITableViewController {
    
    // 위시리스트에 추가된 영화 목록
    var wishList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블 뷰 설정
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MovieCell")
        
        // 예시로 위시리스트에 영화 추가
        let movie1 = Movie(title: "인셉션", director: "크리스토퍼 놀란", releaseYear: 2010)
        let movie2 = Movie(title: "어벤져스", director: "조스 웨던", releaseYear: 2012)
        
        // 위시리스트에 추가
        wishList = [movie1, movie2]
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        
        // 영화 데이터를 셀에 표시
        let movie = wishList[indexPath.row]
        cell.textLabel?.text = movie.title // 영화 제목을 표시
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 선택한 영화에 대한 추가 동작을 구현할 수 있습니다.
    }
    
}
