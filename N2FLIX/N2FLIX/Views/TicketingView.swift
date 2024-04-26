//
//  BookATicketView.swift
//  ForTest
//
//  Created by 쌩 on 4/24/24.
//

import UIKit

import SnapKit

class TicketingPageView: UIView {
    
    private let contentView = UIView()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chevronBack_icon"), for: .normal)
        return button
    }() // 맨 위 좌측
    
    let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        return imageView
    }()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    // Mark: "상영시간"라벨, 상영일, 상영시간
    let screeningTimeSV: UIStackView = {
        let stView = UIStackView()
        return stView
    }()
    
    private let screenTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "상영시간"
        label.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5568627451, alpha: 1)
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.backgroundColor = .clear
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.minimumDate = .now
        return datePicker
    }()
    
    // Mark: "인원"라벨, 실제 인원 라벨, 스테퍼
    let ticketsSV: UIStackView = {
        let stView = UIStackView()
        return stView
    }()
    
    private let personsLabel: UILabel = {
        let label = UILabel()
        label.text = "인원"
        label.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5568627451, alpha: 1)
        return label
    }()
    
    let ticketAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    let ticketStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.maximumValue = 8
        stepper.minimumValue = 0
        stepper.value = 0
        //        stepper.set
        //        stepper.setDecrementImage(stepper.decrementImage(for: .normal), for: .normal)
        //        stepper.setIncrementImage(UIImage(named: "increment_icon"), for: .normal)
        return stepper
    }()
    
    // Mark: "총 가격"라벨, "12000 원" 라벨
    private let priceSV: UIStackView = {
        let stView = UIStackView()
        return stView
    }()
    
    private let priceNameLabel: UILabel = {
        let label = UILabel()
        label.text = "총 가격"
        label.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5568627451, alpha: 1)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "원"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        //글자 크기 조절
        label.textColor = .white
        return label
    }()
    
    let payButton: UIButton = {
        let button = UIButton()
        button.setTitle("결제하기", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.1386153698, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        addViews()
        setConstraints()
    }
    
    // MARK: - init
    // 생성자 재정의 시 상위에 구현된 필수 생성자도 구현해야 함.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        
    }
    
    func addViews() {
        
        [movieImageView, backButton, movieNameLabel, screeningTimeSV, ticketsSV, priceSV, payButton, cancelButton].forEach{
            addSubview($0)
        }
        [screenTimeLabel, datePicker, ].forEach{
            screeningTimeSV.addSubview($0)
        }
        [personsLabel, ticketAmountLabel, ticketStepper].forEach{
            ticketsSV.addSubview($0)
        }
        [priceNameLabel, priceLabel, currencyLabel].forEach{
            priceSV.addSubview($0)
        }
        
        
    }
    
    private func setConstraints() {
        backButtonConstraints()
        movieImageViewConstraints()
        movieNameLabelConstraints()
        screeningTimeSVConstraints()
        ticketsSVConstraints()
        priceSVConstraints()
        payButtonConstraints()
        cancelButtonConstraints()
    }
    
    //    private func contentViewConstraints() {
    //        contentView.snp.makeConstraints{ make in
    //            make.top.leading.bottom.trailing.equalToSuperview()
    //        }
    //    }
    
    private func backButtonConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(15)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(15)
            make.width.height.equalTo(30)
        }
        
    }
    
    private func movieImageViewConstraints() {
        movieImageView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY).offset(10)
            make.height.equalTo(350)
            make.width.equalTo(250)
        }
    }
    
    private func movieNameLabelConstraints() {
        movieNameLabel.snp.makeConstraints{ make in
            make.trailing.equalToSuperview()
            make.top.equalTo(movieImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(70)
        }
    }
    
    private func screeningTimeSVConstraints() {
        screeningTimeSV.snp.makeConstraints{ make in
            make.leading.centerX.trailing.equalToSuperview()
            make.top.equalTo(movieNameLabel.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        
        screenTimeLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
        }
        
        datePicker.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-5)
        }
        
    }
    
    private func ticketsSVConstraints() {
        ticketsSV.snp.makeConstraints{ make in
            make.leading.centerX.trailing.equalToSuperview()
            make.top.equalTo(screeningTimeSV.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        
        personsLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
        }
        
        ticketAmountLabel.snp.makeConstraints{ make in
            make.trailing.equalTo(ticketStepper.snp.leading).offset(-15)
            make.centerY.equalToSuperview()
        }
        
        
        ticketStepper.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    
    private func priceSVConstraints() {
        priceSV.snp.makeConstraints{ make in
            make.leading.centerX.trailing.equalToSuperview()
            make.top.equalTo(ticketsSV.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        
        priceNameLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints{ make in
            make.trailing.equalTo(currencyLabel.snp.leading).offset(-5)
            make.centerY.equalToSuperview()
        }
        
        currencyLabel.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview()
        }
    }
    
    private func payButtonConstraints() {
        payButton.snp.makeConstraints{ make in
            make.leading.centerX.trailing.equalToSuperview()
            make.bottom.equalTo(cancelButton.snp.top).offset(-7)
            make.height.equalTo(44)
        }
    }
    
    private func cancelButtonConstraints() {
        cancelButton.snp.makeConstraints{ make in
            make.leading.centerX.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(44)
        }
    }
    
    
    
    
    
}
