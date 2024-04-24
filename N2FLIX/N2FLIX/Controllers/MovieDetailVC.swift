//
//  MovieDetailVC.swift
//  N2FLIX
//
//  Created by 쌩 on 4/23/24.
//

import UIKit

import SnapKit


class MovieDetailVC: UIViewController {
    var movieData = MovieData(results: [Result(adult: true, genreIDS: [15], id: 823464, overview: "안녕디지몬", popularity: 5.5, posterPath: "/hil2ResSCwP95JweZVJsZ5CbZdc.jpg", releaseDate: "2024-03-27", title: "Omen", voteAverage: 5.6, voteCount: 444)])
    
    var movieDetailModel = MovieDetailModel(adult: false, genres: [Genre(id: 878, name: "SF")], id: 823464, overview: "고질라 X 콩, 이번에는 한 팀이다! ‘고질라’ VS ‘콩’, 두 타이탄의 전설적인 대결 이후 할로우 어스에 남은 ‘콩’은 드디어 애타게 찾던 동족을 발견하지만 그 뒤에 도사리고 있는 예상치 못한 위협에 맞닥뜨린다. 한편, 깊은 동면에 빠진 ‘고질라’는 알 수 없는 신호로 인해 깨어나고 푸른 눈의 폭군 ‘스카 킹’의 지배 아래 위기에 처한 할로우 어스를 마주하게 된다. 할로우 어스는 물론, 지구상에도 출몰해 전세계를 초토화시키는 타이탄들의 도발 속에서 ‘고질라’와 ‘콩’은 사상 처음으로 한 팀을 이뤄 반격에 나서기로 하는데…", posterPath: "/4z1VMmlxHrziG45901esjB4dpIa.jpg", releaseDate: "2024-03-27", runtime: 115, status: "Released", title: "고질라 X 콩: 뉴 엠파이어", voteAverage: 6.669)
    
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
}

extension MovieDetailVC {
    
    final private func setUI() {
        setDetails()
        setLayout()
    }
    
    final private func setDetails() {
        movieImageView.image = urlToImage(myUrl: "https://image.tmdb.org/t/p/w500/\(self.movieDetailModel.posterPath)")
        movieImageView.contentMode = .scaleToFill
        hdMarkImageView.image = UIImage(named: "hdLogo")
        hdMarkImageView.contentMode = .scaleAspectFit
        
        backButton.setImage(UIImage(systemName: "xmark.circle", withConfiguration: UIImage.SymbolConfiguration(scale: .large))?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        
        // Mark: 제목이 길면 (부제 포함 ":" 을 통해 앞 뒤 구분해서 줄바꿈 추가...?
        movieNameLabel.text = self.movieDetailModel.title
        movieNameLabel.numberOfLines = 0
        movieNameLabel.textColor = .white
        
        releaseDateLabel.text = self.movieDetailModel.releaseDate
        releaseDateLabel.textColor = .white
        runTimeLabel.text = "\(self.movieDetailModel.runtime)분"
        runTimeLabel.textColor = .white
        
        detailStackView.axis = .horizontal
        detailStackView.alignment = .center
        genresLabel.text = "\(self.movieDetailModel.genres.map{$0.name})"
        genresLabel.textColor = .white
        starRatingLabel.text = "\(self.movieDetailModel.voteAverage)"
        starRatingLabel.textColor = .white
        
        overViewText.text = self.movieDetailModel.overview
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
    
    final private func urlToImage(myUrl: String) -> UIImage? {
        if myUrl.isEmpty || myUrl.count == 0 {
            return nil
        }
        do {
            let url = URL(string: myUrl)
            
            if url != nil {
                let data = try Data(contentsOf: url!)
                return UIImage(data: data)
            }
            
        } catch (let error) {
            print("\(error)")
        }
        return nil
    }
    
    @objc func pushMovieReservationPage() {
        //        self.present(movieDetailVC, animated: true)
    }
}
