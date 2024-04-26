//
//  MyPageViewController.swift
//  N2FLIX
//
//  Created by Jeong-bok Lee on 4/23/24.
//

import UIKit

class MyPageViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var changeNicknameButton: UIButton!
    @IBOutlet weak var bookingHistoryButton: UIButton!
    @IBOutlet weak var wishListButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    // MARK: - Lifecycle Methods
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfileImageView()
        updateUserInfo() // 실제 사용자 정보를 가져와서 UI 업데이트
        setupBackButton()
        setupImageSelectionNotification()
    }
    
    // MARK: - UI Setup Methods
    
    private func setupProfileImageView() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 2.0
        profileImageView.layer.borderColor = UIColor(white: 0.28, alpha: 1.0).cgColor
    }
    
    private func setupBackButton() {
        let backButtonImage = UIImage(named: "Icon/chevronBack_icon")
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    // MARK: - Data Update Methods
    
    // !UserData 데이터
    func updateUserInfo() {
        let userData = UserData.shared
        let nickname = userData.userNickName ?? "Guest"
        let email = userData.userID ?? "n2flix@gmail.com"
        nicknameLabel.text = nickname
        emailLabel.text = email
    }
    
    func updateNickname(_ newNickname: String) {
        var userData = UserData.shared
        userData.userNickName = newNickname
        nicknameLabel.text = newNickname
    }
    
    // MARK: - Action Methods
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true) // 이전 화면으로 이동 (!페이지 연결)
    }
    
    @objc func didSelectImage(_ notification: Notification) {
        guard let imageName = notification.object as? String else { return }
        profileImageView.image = UIImage(named: imageName) // 선택된 이미지로 프로필 이미지 업데이트
    }
    
    @IBAction func profileButtonTapped(_ sender: UIButton) {
        let imageSelectionVC = ImageSelectionViewController()
         imageSelectionVC.modalPresentationStyle = .overCurrentContext
         present(imageSelectionVC, animated: true) {
         }
     }
    
    @IBAction func changeNicknameButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "닉네임 변경", message: "새로운 닉네임을 입력하세요.", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "같이 밥 먹고 싶은 개발자"
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "저장", style: .default) { [weak self] action in
            guard let newNickname = alertController.textFields?.first?.text else { return }
            
            self?.updateNickname(newNickname) // 새로운 닉네임으로 업데이트
        }
        saveAction.isEnabled = false
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let saveAction = (presentedViewController as? UIAlertController)?.actions.last
        saveAction?.isEnabled = !text.isEmpty // 텍스트가 입력되면 저장 버튼 활성화
    }
    
    @IBAction func bookingHistoryButtonTapped(_ sender: UIButton) {
        let bookingHistoryVC = BookingHistoryViewController()
        navigationController?.pushViewController(bookingHistoryVC, animated: true)
    }
    
    @IBAction func wishListButtonTapped(_ sender: UIButton) {
        let wishListVC = UIStoryboard(name: "WishList", bundle: nil).instantiateViewController(withIdentifier: "WishListViewController") as! WishListViewController
        wishListVC.modalPresentationStyle = .fullScreen
        present(wishListVC, animated: false)
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "로그아웃", message: "정말 떠나실건가요?", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "떠나기", style: .destructive) { _ in
            UserData.shared.logout() // 사용자 로그아웃
            self.navigationController?.popToRootViewController(animated: true) // 루트 뷰 컨트롤러로 이동 (!로그인 페이지와 연결)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: - Helper Methods
    
    // 프로필 이미지 데이터
    private func setupImageSelectionNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectImage(_:)), name: .didSelectImage, object: nil)
    }
}

extension Notification.Name {
    static let didSelectImage = Notification.Name("didSelectImage")
}
