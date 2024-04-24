//
//  BookingHistoryViewController.swift
//  N2FLIX
//
//  Created by Jeong-bok Lee on 4/23/24.
//

import UIKit


class BookingCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var screeningTimeLabel: UILabel!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var paymentAmountLabel: UILabel!
    
    func configure(with booking: Booking) {
        movieTitleLabel.text = booking.movieTitle
        screeningTimeLabel.text = booking.screeningTime
        numberOfPeopleLabel.text = "\(booking.numberOfPeople)명"
        paymentAmountLabel.text = "\(booking.paymentAmount)원"
    }
}

class BookingHistoryViewController: UITableViewController {
    
    var bookingHistory: [Booking] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // 예매 내역을 표시할 셀을 등록
//        let nib = UINib(nibName: "BookingCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "BookingCell")
        
        // 예시로 예매 내역 데이터 추가
        let booking1 = Booking(movieTitle: "범죄도시4 (2024) THE ROUNDUP : PUNISHMENT", screeningTime: "2024-04-23", numberOfPeople: 2, paymentAmount: 24000)
        let booking2 = Booking(movieTitle: "범죄도시4 (2024) THE ROUNDUP : PUNISHMENT", screeningTime: "2024-04-24", numberOfPeople: 3, paymentAmount: 36000)
        
        // 예매 내역 배열에 추가
        bookingHistory = [booking1, booking2]
        
        // 상단 여백 추가
        tableView.contentInset = UIEdgeInsets(top: 16.0, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingHistory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as! BookingCell
        
        // 예매 내역 데이터를 셀에 표시
        let booking = bookingHistory[indexPath.row]
        cell.configure(with: booking)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 선택한 예매 내역에 대한 추가 동작을 구현할 수 있습니다.
    }
    
    // MARK: - Actions
    
    @IBAction func closeButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { [weak self] (action, view, completionHandler) in
            // 삭제 확인 알림창 표시
            let alertController = UIAlertController(title: "예매 삭제", message: "예매 내역을 삭제하실 건가요?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
                completionHandler(false) // 삭제 취소
            }
            let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
                // 예매 내역 배열에서 해당 항목 삭제
                self?.bookingHistory.remove(at: indexPath.row)
                // 테이블 뷰에서 해당 셀 삭제
                tableView.deleteRows(at: [indexPath], with: .fade)
                completionHandler(true) // 삭제 완료
            }
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            self?.present(alertController, animated: true, completion: nil)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

