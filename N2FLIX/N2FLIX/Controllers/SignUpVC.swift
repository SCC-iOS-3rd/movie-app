//
//  SignUpVC.swift
//  N2FLIX
//
//  Created by /Chynmn/M1 pro—̳͟͞͞♡ on 4/23/24.
//

import UIKit

final class SignUpVC: UIViewController {
    
    private let signUpView = SignUpView()
    
    override func loadView() {
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
    }

    
    // AutoLayout
    private func setupAddTarget() {
        signUpView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func loginButtonTapped() {
        // TODO: 로그인 과정 구현
        
    }
    
    
    
    
    
    
}
