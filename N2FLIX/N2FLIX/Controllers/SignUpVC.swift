//
//  SignUpVC.swift
//  N2FLIX
//
//  Created by /Chynmn/M1 pro—̳͟͞͞♡ on 4/23/24.
//

import UIKit

final class SignUpVC: UIViewController {
    
    var userData = UserDataManager()
    
    enum UserDefaultsKey: String {
        case isFirstEntryApp
        case isAutoLogin
    }
    
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
//        let vc = MovieListVC()
        guard let email = signUpView.emailTextField.text, !email.isEmpty else { return }
        guard let pw = signUpView.pwTextField.text, !pw.isEmpty else { return }
        
        if userData.isValidEmail(id: email) {
            if let removable = self.view.viewWithTag(100) {
                removable.removeFromSuperview()
            }
        } else {
            // 경고창
            let emailLabel = UILabel(frame: CGRect(x: 68, y: 350, width: 279, height: 45))
                    emailLabel.text = "이메일 형식을 확인해 주세요"
                    emailLabel.textColor = UIColor.red
                    emailLabel.tag = 100
                        
                    self.view.addSubview(emailLabel)
        }
        
        if userData.isValidPassword(pwd: pw) {
            if let removable = self.view.viewWithTag(101) {
                removable.removeFromSuperview()
            }
        } else {
            let passwordLabel = UILabel(frame: CGRect(x: 68, y: 435, width: 279, height: 45))
                    passwordLabel.text = "비밀번호 형식을 확인해 주세요"
                    passwordLabel.textColor = UIColor.red
                    passwordLabel.tag = 101
                        
                    self.view.addSubview(passwordLabel)
        }
    
        if userData.isValidEmail(id: email) && userData.isValidPassword(pwd: pw) {
            let loginSuccess: Bool = loginCheck(id: email, pw: pw)
            if loginSuccess {
                print("로그인 성공")
                if let removable = self.view.viewWithTag(102) {
                    removable.removeFromSuperview()
                }
                
                
                let mainStoryboard = UIStoryboard(name: "MovieList", bundle: nil)
                let mainTableVC = mainStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
                view.window?.rootViewController = mainTableVC
                
                
//                mainTableVC?.modalPresentationStyle = .fullScreen
//                present(mainTableVC!, animated: true) // 꼭 쓰려면 풀 스크린
                
//                self.navigationController?.pushViewController(mainTableVC, animated: true)
                
            }
            else {
                print("로그인 실패")
                let loginFailLabel = UILabel(frame: CGRect(x: 68, y: 510, width: 279, height: 45))
                loginFailLabel.text = "아이디나 비밀번호가 다릅니다."
                loginFailLabel.textColor = UIColor.red
                loginFailLabel.tag = 102
                
                self.view.addSubview(loginFailLabel)
            }
        }
        
    }
    
    func loginCheck(id: String, pw: String) -> Bool {
        for user in userData.users {
            if user.userEmail == id && user.userPW == pw {
                print("로그인 성공")
                return true
            }
        }
        print("fail")
        return false
    }
    
    
    func saveIdAndPwInUserDefaults() {
        guard let id = signUpView.emailTextField.text, let pw = signUpView.pwTextField.text else { return }
        UserDefaults.standard.setValue(id, forKey: "id")
        UserDefaults.standard.setValue(pw, forKey: "pw")
    }
    

    
    
}
