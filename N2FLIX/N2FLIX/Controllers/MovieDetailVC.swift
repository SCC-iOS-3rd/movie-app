//
//  MovieDetailVC.swift
//  N2FLIX
//
//  Created by 쌩 on 4/23/24.
//

import UIKit

import SnapKit


class MovieDetailVC: UIViewController, UITextViewDelegate {
    let api = APIDatamanager()
    var CDM = CoreDataManager()
    var movieDetailModel: [MovieDetailModel] = []
    var id = 0
    
    let ticketingPageVC = TicketingPageVC()
    var myWish: [UserWish] = []
    
    var genreName = ""
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let backButton = UIButton() // 맨 위 우측
    let movieImageView = UIImageView()
    let movieNameLabel = UILabel()
    let gradientView = UIView()
    let gradientLayer = CAGradientLayer()
    // Mark: progress indicator
    private let wholeViewShield = UIView()
    private let spinner = UIActivityIndicatorView()
    
    
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
        self.view.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        setUI()
        textViewDidChange(overViewText)
        scrollView.updateContentSize()
        gradientLayer.frame = gradientView.bounds
        spinner.startAnimating()
        
        // Mark: 뷰 로드될 때 코어데이터 읽어와서 찜 되어있는 목록인지 확인 -> 결과에 따라
        // 찜하기 Or
        checkMyWishCoreData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gradientLayer.frame = gradientView.bounds
        // Mark: 그라디언트뷰의 바운즈의 인식이 실행단계와 다르게 늦어져서 쉬는시간을 주고  시간 지연 후 본 뷰를 보여줌.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.wholeViewShield.removeFromSuperview()
            self.spinner.stopAnimating()
        }
     
    }
}

extension MovieDetailVC {
    final private func setUI() {
        api.readAPI(word: String(self.id), forSearch: false, type: MovieDetailModel.self) {movieDetail in
            self.movieDetailModel.append(movieDetail)
            // Mark: 장르 이름 뽑아오기, 형태 지정
            movieDetail.genres.map{$0.name}.forEach{self.genreName += "\($0) "}
            DispatchQueue.main.async {
                self.setLayout()
                self.setDetails()
            }
        }
    }
    
    final private func setDetails() {
        
        api.readImage("https://image.tmdb.org/t/p/w500/\( self.movieDetailModel[0].posterPath)") {data in
            DispatchQueue.main.async {
                self.movieImageView.image  = UIImage(data: data)
            }
        
        }
    

        
        movieImageView.contentMode = .scaleAspectFill
        hdMarkImageView.image = UIImage(named: "hdLogo")
        hdMarkImageView.contentMode = .scaleAspectFit
        
        backButton.setImage(UIImage(named: "Icon/cancel_icon"), for: .normal)
        backButton.addTarget(self, action: #selector(touchupBackButton), for: .touchUpInside)
        // Mark: 제목이 길면 (부제 포함 ":" 을 통해 앞 뒤 구분해서 줄바꿈 추가...?
        movieNameLabel.text =  self.movieDetailModel[0].title
        movieNameLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        movieNameLabel.numberOfLines = 0
        movieNameLabel.textColor = .white
        
        releaseDateLabel.text =  self.movieDetailModel[0].releaseDate
        releaseDateLabel.textColor = .white
        releaseDateLabel.font = UIFont.systemFont(ofSize: 13)
        runTimeLabel.text = "\( self.movieDetailModel[0].runtime)분"
        runTimeLabel.textColor = .white
        runTimeLabel.font = UIFont.systemFont(ofSize: 13)
        
        
        detailStackView.axis = .horizontal
        detailStackView.alignment = .center
        genresLabel.text = self.genreName
        genresLabel.textColor = .white
        genresLabel.font = UIFont.systemFont(ofSize: 13)
        // Mark: 소수 2번째 자리에서 글자 자름
        starRatingLabel.text = "평점 : \(String(format: "%.2f", self.movieDetailModel[0].voteAverage))"
        starRatingLabel.textColor = .white
        //        self.movieDetailModel[0].voteAverage
        
        overViewText.setLineAndLetterSpacing(self.movieDetailModel[0].overview)
        overViewText.font = .systemFont(ofSize: 15)
        overViewText.textColor = .white.withAlphaComponent(0.6)
        overViewText.textAlignment = NSTextAlignment.left
        overViewText.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        overViewText.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        overViewText.delegate = self
        overViewText.isScrollEnabled = false
        
        bookingButton.setTitle("예매하기", for: .normal)
        bookingButton.backgroundColor = .white
        bookingButton.setTitleColor(.black, for: .normal)
        bookingButton.addTarget(self, action: #selector(pushTicketingPage), for: .touchUpInside)
        
        ticketingPageVC.modalPresentationStyle = .automatic
        // Mark: addWishListButton은 찜 해두었고, 안해두었고에 따라 생김새가 바뀌어야함.
        //        if true {
        addWishListButton.setTitle("찜하기", for: .normal)
        //        } else {
        //            addWishListButton.setTitle("찜하기 취소", for: .normal)
        //        }
        addWishListButton.backgroundColor = #colorLiteral(red: 0.1827788651, green: 0.1880517602, blue: 0.1930513084, alpha: 1)
        addWishListButton.setTitleColor(.white, for: .normal)
        addWishListButton.addTarget(self, action: #selector(touchupAddMyWishButton), for: .touchUpInside)
        spacer.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        
        
        scrollView.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        contentView.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        
        gradientView.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        gradientView.backgroundColor = .clear
        
        gradientLayer.colors = [UIColor.clear.cgColor, #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.locations = [0.0, 0.4 ,1.0]
      
        
        wholeViewShield.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
    }
    
    final private func setLayout() {
        self.view.addSubview(scrollView)
        //        self.view.addSubview(overViewText)
        // Mark: bookingButton은 예약 가능한 영화라는 조건 필요
        if true {
            self.view.addSubview(bookingButton)
            self.view.addSubview(spacer)
            
        }
        self.view.addSubview(addWishListButton)
        self.view.addSubview(backButton)
        gradientView.layer.addSublayer(gradientLayer)
        
        addWishListButton.snp.makeConstraints { make in
            make.centerX.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        spacer.snp.makeConstraints { make in
            make.centerX.leading.trailing.equalToSuperview()
            make.bottom.equalTo(addWishListButton.snp.top)
            make.height.equalTo(5)
        }
        
        bookingButton.snp.makeConstraints { make in
            make.centerX.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
            make.bottom.equalTo(addWishListButton.snp.top).offset(-5)
        }
        
        scrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(bookingButton.snp.top).offset(-4)
        }
        
        scrollView.addSubview(contentView)
        scrollView.addSubview(overViewText)
        
        [movieImageView, gradientView, movieNameLabel, detailStackView, genresLabel, starRatingLabel].forEach {
            contentView.addSubview($0)
        }
        
        [releaseDateLabel, hdMarkImageView, runTimeLabel].forEach {
            detailStackView.addSubview($0)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(800)
        }
        
        movieImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentView).offset(0)
            make.height.equalTo(550)
            make.leading.trailing.equalTo(contentView)
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(gradientView.snp.centerY).offset(-24)
            make.width.equalToSuperview().inset(13)
            make.height.equalTo(50) // 수정 필요
        }
        // Mark: 개봉일, HD마크, 런타임
        detailStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(movieNameLabel.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(13)
            make.height.equalTo(40)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        hdMarkImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(releaseDateLabel.snp.trailing).offset(8)
            make.width.equalTo(30)
        }
        runTimeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(hdMarkImageView.snp.trailing).offset(8)
        }
        
        genresLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(detailStackView.snp.bottom).offset(-10)
            make.width.equalToSuperview().inset(13)
            //            make.height.equalTo(40)
        }
        
        starRatingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(genresLabel.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(13)
        }
        
        overViewText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(starRatingLabel.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(8)
            make.height.equalTo(10)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        gradientView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(movieImageView.snp.centerY)
            make.bottom.equalToSuperview()
        }
        
        self.view.addSubview(wholeViewShield)
        wholeViewShield.addSubview(spinner)
        wholeViewShield.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        spinner.snp.makeConstraints{ make in
            make.centerY.centerX.equalToSuperview()
            make.height.width.equalTo(200)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text ?? "")
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    @objc func pushTicketingPage() {
        ticketingPageVC.ticketingModel = self.movieDetailModel
        self.present(ticketingPageVC, animated: true)
    }
    
    @objc
    private func touchupBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    // Mark: 이곳에서 myWish를 CoreData에 추가.
    @objc private func touchupAddMyWishButton() {
        CDM.saveWish(myWish: UserWish(title: movieDetailModel[0].title, posterPath: movieDetailModel[0].posterPath, id: movieDetailModel[0].id))
        addWishDoneAlert()
    }
    
    @objc func addWishDoneAlert() {
            let controller = UIAlertController(title: "완료", message: nil, preferredStyle: UIAlertController.Style.alert)
            controller.message =  "찜한목록에 추가되었습니다."
            
            let okAction = UIAlertAction(title: "OK", style: .default){ (action) in
            }
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
        }
    
    // Mark: 코어데이터 읽어오기.
    private func checkMyWishCoreData() {
    }
}

extension UIScrollView {
    func updateContentSize() {
        let unionCalculatedTotalRect = recursiveUnionInDepthFor(view: self)
        
        // 계산된 크기로 컨텐츠 사이즈 설정
        self.contentSize = CGSize(width: self.frame.width, height: unionCalculatedTotalRect.height+50)
    }
    
    private func recursiveUnionInDepthFor(view: UIView) -> CGRect {
        var totalRect: CGRect = .zero
        
        // 모든 자식 View의 컨트롤의 크기를 재귀적으로 호출하며 최종 영역의 크기를 설정
        for subView in view.subviews {
            totalRect = totalRect.union(recursiveUnionInDepthFor(view: subView))
        }
        
        // 최종 계산 영역의 크기를 반환
        return totalRect.union(view.frame)
    }
}


// 줄 간격 기능 확장
extension UITextView {
    func setLineAndLetterSpacing(_ text: String){
        let style = NSMutableParagraphStyle()
        // 행간 세팅
        style.lineSpacing = 6
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(0), range: NSRange(location: 0, length: attributedString.length))
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
}
