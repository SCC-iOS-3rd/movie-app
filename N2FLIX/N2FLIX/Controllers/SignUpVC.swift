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
        guard let email = signUpView.emailTextField.text, !email.isEmpty else { return }
        guard let pw = signUpView.pwTextField.text, !pw.isEmpty else { return }
        
        if userData.isValidEmail(email: email) {
            if let removable = self.view.viewWithTag(100) {
                removable.removeFromSuperview()
            }
        } else {
            // 경고창
            let emailLabel = UILabel(frame: CGRect(x: 35, y: 370, width: 279, height: 45))
            emailLabel.text = "이메일 형식을 확인해 주세요"
            emailLabel.font = UIFont.systemFont(ofSize: 14)
            emailLabel.textColor = UIColor.red
            emailLabel.tag = 100
            
            self.view.addSubview(emailLabel)
        }
        
        if userData.isValidPassword(pwd: pw) {
            if let removable = self.view.viewWithTag(101) {
                removable.removeFromSuperview()
            }
        } else {
            let passwordLabel = UILabel(frame: CGRect(x: 35, y: 439, width: 279, height: 45))
            passwordLabel.text = "비밀번호 형식을 확인해 주세요"
            passwordLabel.font = UIFont.systemFont(ofSize: 14)
            passwordLabel.textColor = UIColor.red
            passwordLabel.tag = 101
            
            self.view.addSubview(passwordLabel)
        }
        
        if userData.isValidEmail(email: email) && userData.isValidPassword(pwd: pw) {
            let loginSuccess: Bool = loginCheck(email: email, pw: pw)
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
//
//                self.navigationController?.pushViewController(mainTableVC, animated: true)
            }
            else {
                print("로그인 실패")
                userData.users.append(UserData(userEmail: email, userPW: pw, userNickName: "Guset"))
                let signUpMassage = "회원가입이 완료 되었습니다"
                let signUpGuide = "'다음' 버튼을 눌러 로그인 과정을 진행해 주세요"
                
                let alert = UIAlertController(title: signUpMassage, message: signUpGuide, preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
            
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func loginCheck(email: String, pw: String) -> Bool {
        for user in userData.users {
            if user.userEmail == email && user.userPW == pw {
                print("로그인 성공")
                return true
            }
        }
        print("fail")
        return false
    }
    
    
    func saveIdAndPwInUserDefaults() {
        guard let email = signUpView.emailTextField.text, let pw = signUpView.pwTextField.text else { return }
        UserDefaults.standard.setValue(email, forKey: "email")
        UserDefaults.standard.setValue(pw, forKey: "pw")
    }
}
