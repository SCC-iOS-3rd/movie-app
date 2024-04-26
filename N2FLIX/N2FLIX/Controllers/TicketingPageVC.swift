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
    
    var ticketingModel = [MovieDetailModel]()

    override func loadView() {
        view = tickectingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButtonAction()
        fetchDataToView()
        stepperAddTarget()
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
    }
    
    func stepperAddTarget() {
        self.tickectingView.ticketStepper.addTarget(self , action: #selector(stepperTapped(_: )), for: .touchUpInside)
    }
    
    @objc func stepperTapped(_ sender: UIStepper) {
        print(sender.value)
        
        let stepperNum = Int(sender.value)
        tickectingView.ticketAmountLabel.text = Int(sender.value).description

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        if let totalPrice = numberFormatter.string(for: Int(sender.value) * 14000 ) {
            tickectingView.priceLabel.text = "\(totalPrice)"
        }
    }
    
    
    
    @objc func goBackPage() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func DoTicketing() {
        
    }
}
