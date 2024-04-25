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
    
    @objc func goBackPage() {
        self.dismiss(animated: true, completion: nil)
    }
}
