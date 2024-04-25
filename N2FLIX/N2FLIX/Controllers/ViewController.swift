//
//  ViewController.swift
//  N2FLIX
//
//  Created by /Chynmn/M1 pro—̳͟͞͞♡ on 4/22/24.
//

//import UIKit
//
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        // Do any additional setup after loading the view.
        
    }
    
    
    
    
    @objc func pushMovieDetailPage() {
        self.present(movieDetailVC, animated: true)
    }
}
