//
//  BookingHistoryViewController.swift
//  N2FLIX
//
//  Created by Jeong-bok Lee on 4/23/24.
//

import UIKit

struct Booking {
    let movieTitle: String
    let bookingDate: Date
    // 예매에 관련된 다른 속성들을 필요에 따라 추가할 수 있습니다.
}

class BookingHistoryViewController: UITableViewController {
    
    // 예매 내역을 저장할 배열
    var bookingHistory: [Booking] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 예시로 예매 내역 데이터 추가
          let booking1 = Booking(movieTitle: "영화 제목 1", bookingDate: Date())
          let booking2 = Booking(movieTitle: "영화 제목 2", bookingDate: Date())
           
          // 예매 내역 배열에 추가
          bookingHistory = [booking1, booking2]
          
        // 테이블 뷰 설정
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BookingCell")
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingHistory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath)
        
        // 예매 내역 데이터를 셀에 표시
        let booking = bookingHistory[indexPath.row]
        cell.textLabel?.text = booking.movieTitle // 예매한 영화 제목을 표시
        
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
    
}
