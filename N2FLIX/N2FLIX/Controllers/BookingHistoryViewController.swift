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
    @IBOutlet weak var containerView: UIView! // 셀의 컨텐트 뷰
      
      override func layoutSubviews() {
          super.layoutSubviews()
          
          // 셀의 컨텐트 뷰의 크기를 조정하여 간격을 설정
          containerView.frame = CGRect(x: 10, y: 10, width: contentView.frame.width - 20, height: contentView.frame.height - 20)
          containerView.layer.cornerRadius = 10
          containerView.layer.shadowColor = UIColor.black.cgColor
          containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
          containerView.layer.shadowOpacity = 0.2
          containerView.layer.shadowRadius = 4
      }
      
    func configure(with booking: ReserveTicket) {
        movieTitleLabel.text = booking.title
        screeningTimeLabel.text = booking.dataTime
        numberOfPeopleLabel.text = "\(booking.totalPrice / 14000)명"
        paymentAmountLabel.text = "\(booking.totalPrice)원"
    }
}

class BookingHistoryViewController: UITableViewController {
    
    let CDM = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 상단 여백 추가
        tableView.contentInset = UIEdgeInsets(top: 16.0, left: 0, bottom: 0, right: 0)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CDM.readReservation().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as! BookingCell
        
        // 예매 내역 데이터를 셀에 표시
        let booking = CDM.readReservation()[indexPath.row]
        cell.configure(with: booking)
        
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
                // 예매 내역 배열에서 해당 항목 삭제
                self!.CDM.deleteReservation(num: indexPath.row)
                // 테이블 뷰에서 해당 셀 삭제
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
    
}

// 결제 금액에 포멧 확장
extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
