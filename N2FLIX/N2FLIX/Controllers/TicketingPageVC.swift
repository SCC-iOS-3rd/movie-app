//
//  MovieReservationVC.swift
//  N2FLIX
//
//  Created by 쌩 on 4/23/24.
//

import UIKit

class TicketingPageVC: UIViewController {
    
    let api = APIDatamanager()
    let tickectingView = TicketingPageView()
    var CDM = CoreDataManager()
    var ticketingModel = [MovieDetailModel]()
    var myTicketDate = ""
    var myTicketPrice = 0
    
    override func loadView() {
        view = tickectingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonAction()
        fetchDataToView()
        stepperAddTarget()
        setMaximumDate()
        datePickerAddTarget()
    }
    
}

extension TicketingPageVC {
    
    private func fetchDataToView() {
        self.fetchMovieImage()
        self.fetchMovieName()
    }
    
    private func fetchMovieImage() {
        api.readImage("https://image.tmdb.org/t/p/w500/\( ticketingModel[0].posterPath)") {data in
            DispatchQueue.main.async {
                self.tickectingView.movieImageView.image  = UIImage(data: data)
            }
        }
    }
    
    private func fetchMovieName() {
        tickectingView.movieNameLabel.text = ticketingModel[0].title
    }
    
    
    private func addButtonAction() {
        tickectingView.backButton.addTarget(self, action: #selector(goBackPage), for: .touchUpInside)
        tickectingView.cancelButton.addTarget(self, action: #selector(goBackPage), for: .touchUpInside)
        tickectingView.payButton.addTarget(self, action: #selector(checkTicketting), for: .touchUpInside)
    }
    
    func stepperAddTarget() {
        self.tickectingView.ticketStepper.addTarget(self , action: #selector(stepperTapped(_: )), for: .touchUpInside)
    }
    
    @objc func stepperTapped(_ sender: UIStepper) {
        tickectingView.ticketAmountLabel.text = Int(sender.value).description
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        if let totalPrice = numberFormatter.string(for: Int(sender.value) * 14000 ) {
            tickectingView.priceLabel.text = "\(totalPrice)"
        }
        myTicketPrice = Int(sender.value) * 14000
    }
    
    func setMaximumDate() {
        var components = DateComponents()
        let calender = Calendar(identifier: .gregorian)
        let currentDate = Date()
        components.calendar = calender
        components.day = +14
        let maxDate = calender.date(byAdding: components, to: currentDate)
        self.tickectingView.datePicker.maximumDate = maxDate
    }
    
    func datePickerAddTarget() {
        self.tickectingView.datePicker.addTarget(self, action: #selector(handleDatePicker(_: )), for: .valueChanged)
    }
    
    @objc
    private func handleDatePicker(_ sender: UIDatePicker) {
//        print(sender.date)
        self.myTicketDate = sender.date.description
    }
    
    @objc func goBackPage() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func checkTicketting() {
        if myTicketDate == "" {
            self.ticketTimeErrorAlert()
        } else if myTicketPrice == 0 {
            self.ticketAmountErrorAlert()
        } else {
            self.paymentAlert()
        }
        
    }
    
    @objc func DoTicketing() {
        CDM.saveReservation(reservationData: ReserveTicket(dataTime: self.myTicketDate, totalPrice: myTicketPrice, title: "\(ticketingModel[0].title)", posterPath: "\(ticketingModel[0].posterPath) "))
        
//        print(myTicketModel)
    }
    
    @objc func paymentAlert() {
            let controller = UIAlertController(title: "예매하시겠습니까?", message: nil, preferredStyle: UIAlertController.Style.alert)
        controller.message =  "총 구매가격 \(self.myTicketPrice)입니다. "

            
            let okAction = UIAlertAction(title: "OK", style: .default){ (action) in
                
                self.DoTicketing()
                }
            
            let cancel = UIAlertAction(title: "cancel", style: .destructive, handler : nil)
           
            controller.addAction(cancel)
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
        }
    
    @objc func ticketAmountErrorAlert() {
            let controller = UIAlertController(title: "예매 내용을 확인해주세요.", message: nil, preferredStyle: UIAlertController.Style.alert)
        controller.message =  "예매하실 티켓 수를 선택해주세요"

            
            let okAction = UIAlertAction(title: "OK", style: .default){ (action) in
                self.DoTicketing()
                }
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
        }
    
    @objc func ticketTimeErrorAlert() {
            let controller = UIAlertController(title: "예매 내용을 확인해주세요.", message: nil, preferredStyle: UIAlertController.Style.alert)
        controller.message =  "상영일자와 시간을 선택해주세요."
            
            let okAction = UIAlertAction(title: "OK", style: .default){ (action) in
                }
            
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
        }
}
