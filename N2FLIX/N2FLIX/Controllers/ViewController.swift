//
//  ViewController.swift
//  N2FLIX
//
//  Created by /Chynmn/M1 pro—̳͟͞͞♡ on 4/22/24.
//

import UIKit

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

