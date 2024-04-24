//
//  MovieDetailVC.swift
//  N2FLIX
//
//  Created by 쌩 on 4/23/24.
//

import UIKit

import SnapKit


class MovieDetailVC: UIViewController {
    let api = APIDatamanager()
    
    var movieDetailModel: [MovieDetailModel] = []
    var id = 0
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let backButton = UIButton() // 맨 위 우측
    let movieImageView = UIImageView()
    let movieNameLabel = UILabel()
    
    let detailStackView = UIStackView() // 개봉일, HD마크, 런타임
    
    let releaseDateLabel = UILabel()
    let hdMarkImageView = UIImageView()
    let runTimeLabel = UILabel()
    
    let genresLabel = UILabel()
    let starRatingLabel = UILabel() // 시간되면 별로 변환(StackVIew)
    let overViewText = UITextView()
    let bookingButton = UIButton()
    let addWishListButton = UIButton()
    let spacer = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setUI()
    }
    
    @objc func pushMovieReservationPage() {
        //        self.present(movieDetailVC, animated: true)
    }

}

extension MovieDetailVC {
    final private func setUI() {
        api.readDetailAPI(id: "\(id)") {movieDetail in
            self.movieDetailModel.append(movieDetail)
            DispatchQueue.main.async {
                self.setDetails()
                self.setLayout()
            }
        }
    }
    
    final private func setDetails() {
        api.readImage("https://image.tmdb.org/t/p/w500/\( self.movieDetailModel[0].posterPath)") {data in
            DispatchQueue.main.async {
                self.movieImageView.image  = UIImage(data: data)
            }
        }
       
        
        movieImageView.contentMode = .scaleToFill
        hdMarkImageView.image = UIImage(named: "hdLogo")
        hdMarkImageView.contentMode = .scaleAspectFit
        
        backButton.setImage(UIImage(named: "cancel_icon"), for: .normal)
        
        // Mark: 제목이 길면 (부제 포함 ":" 을 통해 앞 뒤 구분해서 줄바꿈 추가...?
        movieNameLabel.text =  self.movieDetailModel[0].title
        movieNameLabel.numberOfLines = 0
        movieNameLabel.textColor = .white
        
        releaseDateLabel.text =  self.movieDetailModel[0].releaseDate
        releaseDateLabel.textColor = .white
        runTimeLabel.text = "\( self.movieDetailModel[0].runtime)분"
        runTimeLabel.textColor = .white
        
        detailStackView.axis = .horizontal
        detailStackView.alignment = .center
        genresLabel.text = "\( self.movieDetailModel[0].genres.map{$0.name})"
        genresLabel.textColor = .white
        starRatingLabel.text = "\( self.movieDetailModel[0].voteAverage)"
        starRatingLabel.textColor = .white
        
        overViewText.text =  self.movieDetailModel[0].overview
        overViewText.font = .systemFont(ofSize: 15)
        overViewText.textColor = .white
        overViewText.textAlignment = NSTextAlignment.left
        overViewText.backgroundColor = .black
        
        bookingButton.setTitle("예매하기", for: .normal)
        bookingButton.backgroundColor = .white
        bookingButton.setTitleColor(.black, for: .normal)
        
        // Mark: addWishListButton은 찜 해두었고, 안해두었고에 따라 생김새가 바뀌어야함.
        if true {
            addWishListButton.setTitle("찜하기", for: .normal)
        } else {
            addWishListButton.setTitle("찜하기 취소", for: .normal)
        }
        addWishListButton.backgroundColor = .gray
        addWishListButton.setTitleColor(.white, for: .normal)
        spacer.backgroundColor = .black
        
        
        scrollView.backgroundColor = .black
        contentView.backgroundColor = .black
    }
    
    final private func setLayout() {
        self.view.addSubview(scrollView)
        // Mark: bookingButton은 예약 가능한 영화라는 조건 필요
        if true {
            self.view.addSubview(bookingButton)
            self.view.addSubview(spacer)
            
        }
        self.view.addSubview(addWishListButton)
        self.view.addSubview(backButton)
        
        
        addWishListButton.snp.makeConstraints { make in
            make.centerX.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        spacer.snp.makeConstraints { make in
            make.centerX.leading.trailing.equalToSuperview()
            make.bottom.equalTo(addWishListButton.snp.top)
            make.height.equalTo(5)
        }
        
        bookingButton.snp.makeConstraints { make in
            make.centerX.leading.trailing.equalToSuperview()
            make.bottom.equalTo(addWishListButton.snp.top).offset(-5)
        }
        
        scrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(contentView)
        
        [movieImageView, movieNameLabel, detailStackView, genresLabel, starRatingLabel, overViewText].forEach {
            contentView.addSubview($0)
        }
        
        [releaseDateLabel, hdMarkImageView, runTimeLabel].forEach {
            detailStackView.addSubview($0)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(1200)
        }
        
        movieImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentView).offset(0)
            make.height.equalTo(550)
            make.leading.trailing.equalTo(contentView)
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(movieImageView.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(5)
            make.height.equalTo(50) // 수정 필요
        }
        // Mark: 개봉일, HD마크, 런타임
        detailStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(movieNameLabel.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(5)
            make.height.equalTo(40)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        hdMarkImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(releaseDateLabel.snp.trailing).offset(10)
            make.width.equalTo(40)
        }
        runTimeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(hdMarkImageView.snp.trailing).offset(10)
        }
        
        genresLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(detailStackView.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(5)
            //            make.height.equalTo(40)
        }
        
        starRatingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(genresLabel.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(5)
        }
        
        overViewText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(starRatingLabel.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(5)
            make.height.equalTo(450)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }

}
