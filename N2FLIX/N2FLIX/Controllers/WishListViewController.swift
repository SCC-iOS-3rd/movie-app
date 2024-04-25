//
//  WishListViewController.swift
//  N2FLIX
//
//  Created by Jeong-bok Lee on 4/24/24.
//

import UIKit

class WishListViewController: UITableViewController {
    
    var wishList: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cell.xib 파일에 등록된 셀을 사용하기 위해 register 메서드를 호출합니다.
        let nib = UINib(nibName: "Cell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        // 상단 여백 추가
        tableView.contentInset = UIEdgeInsets(top: 16.0, left: 0, bottom: 0, right: 0)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let movie = wishList[indexPath.row]
        cell.textLabel?.text = movie.title
        
        return cell
    }
}
