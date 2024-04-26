//
//  BookingHistoryViewController.swift
//  N2FLIX
//
//  Created by Jeong-bok Lee on 4/23/24.
//

import UIKit

class BookingHistoryViewController: UITableViewController {
    
    var bookingHistory: [Booking] = [] // 예매 내역 정보 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeBookingHistory() // 예매 내역 초기화
        tableView.contentInset = UIEdgeInsets(top: 16.0, left: 0, bottom: 0, right: 0) // 상단 여백 추가
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingHistory.count // 예매 내역 수 반환
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as! BookingCell
        let booking = bookingHistory[indexPath.row]
        cell.configure(with: booking) // 셀에 예매 정보 설정
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // 선택한 행 해제
    }
    // 닫기 버튼 동작
    @IBAction func closeButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    // 셀 스와이프 삭제 기능 설정
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { [weak self] (action, view, completionHandler) in
            // 삭제 확인 알림창 표시
            let alertController = UIAlertController(title: "예매 삭제", message: "정말 삭제하실 건가요?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
                completionHandler(false)
            }
            let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
                // 예매 내역 삭제
                self?.bookingHistory.remove(at: indexPath.row)
                // 해당 셀 삭제
                tableView.deleteRows(at: [indexPath], with: .fade)
                completionHandler(true)
            }
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            self?.present(alertController, animated: true, completion: nil)
        }
        deleteAction.image = UIImage(named: "Icon/trash_icon")
        deleteAction.backgroundColor =  UIColor(red: 0.09, green: 0.09, blue: 0.09, alpha: 0)
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    // 예매 내역 초기화
    private func initializeBookingHistory() {
        // 여기에 실제 데이터를 넣으면 됩니다.
        let booking1 = Booking(movieTitle: "범죄도시4 (2024) THE ROUNDUP : PUNISHMENT", screeningTime: "2024-04-23", numberOfPeople: 2, paymentAmount: 24000)
        let booking2 = Booking(movieTitle: "범죄도시4 (2024) THE ROUNDUP : PUNISHMENT", screeningTime: "2024-04-24", numberOfPeople: 3, paymentAmount: 36000)
        bookingHistory = [booking1, booking2] // 예매 내역 배열에 추가
    }
}

//MARK: - Cell

class BookingCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var screeningTimeLabel: UILabel!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var paymentAmountLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 셀의 컨텐트 뷰의 크기와 스타일 설정
        containerView.frame = CGRect(x: 10, y: 10, width: contentView.frame.width - 20, height: contentView.frame.height - 20)
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowRadius = 4
    }
    
    // 예매 정보 설정
    func configure(with booking: Booking) {
        movieTitleLabel.text = booking.movieTitle
        screeningTimeLabel.text = booking.screeningTime
        numberOfPeopleLabel.text = "\(booking.numberOfPeople)명"
        paymentAmountLabel.text = "\(booking.paymentAmount.withCommas())원"
    }
}

// 결제 금액에 포멧 확장
extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
