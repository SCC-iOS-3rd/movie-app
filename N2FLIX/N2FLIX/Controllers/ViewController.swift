//
//  ViewController.swift
//  N2FLIX
//
//  Created by /Chynmn/M1 pro—̳͟͞͞♡ on 4/22/24.
//

import UIKit

//class ViewController: UIViewController {
//    var M = APIDatamanager()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        DispatchQueue.main.async {
//            self.M.readAPI("now_playing")
//        }
//    }
//}

class ViewController: UIViewController {
    var M = APIDatamanager()
    
    var pushMoviewDetailPageButton = UIButton()
    let movieDetailVC = MovieDetailVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        // Do any additional setup after loading the view.
        self.M.readAPI(word: "top_rated", forSearch: false, type: [Result].self) { movies in
            DispatchQueue.main.async {
                var myMovies : [Result] = []
                myMovies = movies
                self.movieDetailVC.id = myMovies.first?.id ?? 0
            }
            
        }
        
        self.view.addSubview(pushMoviewDetailPageButton)
        pushMoviewDetailPageButton.translatesAutoresizingMaskIntoConstraints = false
        
        pushMoviewDetailPageButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        pushMoviewDetailPageButton.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        pushMoviewDetailPageButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        pushMoviewDetailPageButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        pushMoviewDetailPageButton.setTitle("이동", for: .normal)
        pushMoviewDetailPageButton.setTitleColor(.blue, for: .normal)
        
        movieDetailVC.modalPresentationStyle = .fullScreen
        
        pushMoviewDetailPageButton.addTarget(self, action: #selector(pushMovieDetailPage), for: .touchUpInside)
    }
    
    
    
    
    @objc func pushMovieDetailPage() {
        self.present(movieDetailVC, animated: true)
    }
}
