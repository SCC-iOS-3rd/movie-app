//
//  SignUpView.swift
//  N2FLIX
//
//  Created by /Chynmn/M1 pro—̳͟͞͞♡ on 4/23/24.
//

import UIKit

class SignUpView: UIView {
    
    // MARK: - N2FLIX logo image
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "LaunchScreen/Logo")
//        logoImageView.addSubview()
        return logoImageView
    }()
    
    // MARK: - email 입력 텍스트 뷰
    private lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(emailTextField)
        view.addSubview(emailInfoLabel)
        view.addSubview(emailClearButton)
        return view
    }()
    
    // 로그인할 email 입력 안내
    private let emailInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일을 입력하세요"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        return label
    }()
    
    // email 입력 필드
    lazy var emailTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    // email TextField 일괄 삭제 버튼
    lazy var emailClearButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Icon/cancel_icon"), for: .normal)
        button.addTarget(self, action: #selector(clearTextField(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - PW 입력 텍스트 뷰
    private lazy var pwTextFieldView: UIView = {
        let view = UIView()
        view.frame.size.height = 48
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(pwTextField)
        view.addSubview(pwInfoLabel)
        view.addSubview(pwClearButton)
        view.addSubview(pwSecureButton)
        return view
    }()
    
    // pw 입력 안내
    private let pwInfoLabel: UILabel = {
       let label = UILabel()
        label.text = "비밀번호를 입력하세요"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        return label
    }()
    
    // pw 입력 필드
    lazy var pwTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true
        tf.clearsOnBeginEditing = false
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    // pw 표시/가리기 버튼
    lazy var pwSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash")?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(pwSecureSetting), for: .touchUpInside)
        return button
    }()
    
    // pw TextField 일괄 삭제 버튼
    lazy var pwClearButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Icon/cancel_icon"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(clearTextField(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - 다음(로그인 진행) 버튼
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isEnabled = false
//        button.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        return button
    }()
    
    // stack view
    private lazy var stackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [emailTextFieldView, pwTextFieldView, loginButton])
        stview.spacing = 18
        stview.axis = .vertical
        stview.distribution = .fillEqually
        stview.alignment = .fill
        return stview
    }()
    
    private let textViewHeight: CGFloat = 48
    
    lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    lazy var pwInfoLabelCenterYConstraint = pwInfoLabel.centerYAnchor.constraint(equalTo: pwTextFieldView.centerYAnchor)
    
    // MARK: - init
    // 생성자 재정의 시 상위에 구현된 필수 생성자도 구현해야 함.
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
        emailTextField.delegate = self
        pwTextField.delegate = self
    }
    
    func addViews() {
        [stackView, logoImageView].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        emailInfoLabelConstraints()
        emailTextFieldContraints()
        emailClearButtonConstraints()
        pwInfoLabelConstraints()
        pwTextFieldConstraints()
        pwClearButtonConstraints()
        pwSecureButtonConstraints()
        LogoImageConstraints()
        stackViewConstraints()
        
    }
    
    // MARK: - AutoLayout
    private func LogoImageConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            logoImageView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -50),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 177),
            logoImageView.heightAnchor.constraint(equalToConstant: 151)
        ])
    }
    
    private func emailInfoLabelConstraints() {
        emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
            emailInfoLabelCenterYConstraint
        ])
    }
    
    private func emailTextFieldContraints() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: -2),
            emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8)
        ])
    }
    
    private func emailClearButtonConstraints() {
        emailClearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailClearButton.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
            emailClearButton.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: -15),
            emailClearButton.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
            emailClearButton.widthAnchor.constraint(equalToConstant: 16),
            emailClearButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func pwInfoLabelConstraints() {
        pwInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pwInfoLabel.leadingAnchor.constraint(equalTo: pwTextFieldView.leadingAnchor, constant: 8),
            pwInfoLabel.trailingAnchor.constraint(equalTo: pwTextFieldView.trailingAnchor, constant: -8),
            pwInfoLabelCenterYConstraint
        ])
    }
    
    private func pwTextFieldConstraints() {
        pwTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pwTextField.topAnchor.constraint(equalTo: pwTextFieldView.topAnchor, constant: 15),
            pwTextField.bottomAnchor.constraint(equalTo: pwTextFieldView.bottomAnchor, constant: -2),
            pwTextField.leadingAnchor.constraint(equalTo: pwTextFieldView.leadingAnchor, constant: 8),
            pwTextField.trailingAnchor.constraint(equalTo: pwTextFieldView.trailingAnchor, constant: -8)
        ])
    }
    
    private func pwClearButtonConstraints() {
        pwClearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pwClearButton.topAnchor.constraint(equalTo: pwTextFieldView.topAnchor, constant: 15),
            pwClearButton.bottomAnchor.constraint(equalTo: pwTextFieldView.bottomAnchor, constant: -15),
            pwClearButton.trailingAnchor.constraint(equalTo: pwTextFieldView.trailingAnchor, constant: -8),
            pwClearButton.widthAnchor.constraint(equalToConstant: 16),
            pwClearButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func pwSecureButtonConstraints() {
        pwSecureButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pwSecureButton.topAnchor.constraint(equalTo: pwTextFieldView.topAnchor, constant: 15),
            pwSecureButton.bottomAnchor.constraint(equalTo: pwTextFieldView.bottomAnchor, constant: -15),
            pwSecureButton.trailingAnchor.constraint(equalTo: pwClearButton.trailingAnchor, constant: -25)
        ])
    }
    
    private func stackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 36)
        ])     
    }
    
    // MARK: - email과 PW 모두 입력시 로그인 버튼 활성화
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let email = emailTextField.text, !email.isEmpty,
            let pw = pwTextField.text, !pw.isEmpty
        else {
            loginButton.backgroundColor = .clear
            loginButton.isEnabled = false
            return
        }
        loginButton.backgroundColor = .red
        loginButton.isEnabled = true
    }
    
    // MARK: - 비밀번호 가리기
    @objc private func pwSecureSetting() {
        pwTextField.isSecureTextEntry.toggle()
    }
    
    // MARK: - textField 일괄 삭제
    @objc private func clearTextField(_ sender: UIButton) {
        if sender == emailClearButton {
            emailTextField.text = ""
        } else {
            pwTextField.text = ""
        }
    }

    
    // 빈 화면 클릭 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}

    // MARK: - Extension
extension SignUpView: UITextFieldDelegate {
    
    // textfield 편집 시 문구가 위로 올라가면서 크기를 작게 만들고 오토레이아웃 재설정
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            emailTextFieldView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            emailInfoLabel.font = UIFont.systemFont(ofSize: 11)
            emailInfoLabelCenterYConstraint.constant = -13
        }
        
        if textField == pwTextField {
            pwTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            pwTextFieldView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            pwInfoLabel.font = UIFont.systemFont(ofSize: 11)
            pwInfoLabelCenterYConstraint.constant = -13
        }
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    // textfield 편집 종료 시 설정
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            if emailTextField.text == "" {
                emailTextFieldView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                emailInfoLabel.font = UIFont.systemFont(ofSize: 18)
                emailInfoLabelCenterYConstraint.constant = 0
            }
        }
        
        if textField == pwTextField {
            pwTextFieldView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            if pwTextField.text == "" {
                pwTextFieldView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                pwInfoLabel.font = UIFont.systemFont(ofSize: 18)
                pwInfoLabelCenterYConstraint.constant = 0
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    // Enter 입력 시 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
