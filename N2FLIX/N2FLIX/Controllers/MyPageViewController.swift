//
//  MyPageViewController.swift
//  N2FLIX
//
//  Created by Jeong-bok Lee on 4/23/24.
//

    @IBAction func profileButtonTapped(_ sender: UIButton) {
        let imageSelectionVC = ImageSelectionViewController()
         imageSelectionVC.modalPresentationStyle = .overCurrentContext
         present(imageSelectionVC, animated: true) {
         }
     }
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
    
    let CDM = CoreDataManager()
    let email : String = ""
    let pW : String = ""
    var currentUser = UserData(userEmail: "admin@gmail.com", userPW: "admin1234", userNickName: "Guest")
    
    override func viewDidLoad() {
        super.viewDidLoad()
//         프로필 이미지뷰를 원형으로 만들기
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 2.0
        profileImageView.layer.borderColor = UIColor(red: 71/255.0, green: 71/255.0, blue: 71/255.0, alpha: 1.0).cgColor
        
        // 사용자 정보 설정
        updateUserInfo()
        // 뒤로가기 버튼 추가
        setupBackButton()
        
        // 이미지 선택 알림 등록
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectImage(_:)), name: .didSelectImage, object: nil)
    }

   
    
    // MARK: - UserData Update Methods
    
    // 사용자 정보 업데이트
    func updateUserInfo() {
        // 사용자 정보 가져오기
        for user in CDM.readUser() {
            if user.userEmail == email && user.userPW == pW {
                currentUser = user
            }
        }
        
        // UI 업데이트
        nicknameLabel.text = currentUser.userNickName
        emailLabel.text = currentUser.userEmail
    }

    
    // MARK: - Back Button Setup
    
    // 뒤로가기 버튼 설정
    func setupBackButton() {
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
    
    // MARK: - Action Methods
    
    // 뒤로가기 버튼 액션
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    // 이미지 선택 알림 처리
    @objc func didSelectImage(_ notification: Notification) {
        guard let imageName = notification.object as? String else { return }
        profileImageView.image = UIImage(named: imageName)
    }
    
    // 프로필 이미지 변경 버튼 액션
    @IBAction func profileButtonTapped(_ sender: UIButton) {
        let imageSelectionVC = ImageSelectionViewController()
            imageSelectionVC.modalPresentationStyle = .overCurrentContext
            imageSelectionVC.preferredContentSize = CGSize(width: 320, height: 320)
            present(imageSelectionVC, animated: true, completion: nil)
        }

    // 닉네임 변경 버튼 액션
    @IBAction func changeNicknameButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "닉네임 변경", message: "새로운 닉네임을 입력하세요.", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "새로운 닉네임"
            
            // 텍스트 필드의 내용이 변경될 때마다 호출되는 클로저
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "저장", style: .default) { [weak self] action in
            guard let newNickname = alertController.textFields?.first?.text else { return }
            // 닉네임 업데이트 메서드 호출
            self?.currentUser.userNickName = newNickname
            self?.nicknameLabel.text = newNickname
        }
        saveAction.isEnabled = false // 초기에는 저장 버튼 비활성화
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        present(alertController, animated: true, completion: nil)
    }

    // 텍스트 필드의 내용이 변경될 때 호출되는 메서드
    @objc func textFieldDidChange(_ textField: UITextField) {
        // 입력된 텍스트가 있는지 확인하여 저장 버튼 활성화/비활성화
        guard let text = textField.text else { return }
        let saveAction = (presentedViewController as? UIAlertController)?.actions.last // 저장 버튼
        
        saveAction?.isEnabled = !text.isEmpty // 텍스트가 비어 있지 않으면 버튼 활성화
    }
    
    // 예매한 영화내역 버튼 액션
    @IBAction func bookingHistoryButtonTapped(_ sender: UIButton) {
            let bookingHistoryVC = BookingHistoryViewController()
            navigationController?.pushViewController(bookingHistoryVC, animated: true)
        }
    
    // 찜한 영화 리스트 버튼 액션
    @IBAction func wishListButtonTapped(_ sender: UIButton) {
//                let wishListVC = WishListViewController()
//                navigationController?.pushViewController(wishListVC, animated: true)
    }
    
    // 로그아웃 버튼 액션
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        // 로그아웃 알림창 띄우고 메인화면으로 이동
        let alertController = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "로그아웃", style: .destructive) { _ in
            self.currentUser = UserData(userEmail: "", userPW: "", userNickName: "")
            self.navigationController?.popToRootViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension Notification.Name {
    static let didSelectImage = Notification.Name("didSelectImage")
}
