//
//  UserDataManager.swift
//  N2FLIX
//
//  Created by /Chynmn/M1 pro—̳͟͞͞♡ on 4/26/24.
//

import Foundation

class UserDataManager {
//    static let user = UserDataManager()
    
    var users: [UserData] = [
        UserData(userEmail: "admin@gmail.com", userPW: "admin1234", userNickName: "Guest"),
        UserData(userEmail: "chynmn@gmail.com", userPW: "admin1234", userNickName: "Guest")
    ]
    
    // id validation : @ 앞에 알파벳, 숫자, 특수문자가 포함될 수 있고 @ 뒤에는 알파벳, 숫자, 그리고 . 뒤에는 알파벳 2자리 이상
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    // pw validation : 소문자, 대문자, 숫자 8자리 이상
    func isValidPassword(pwd: String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: pwd)
    }
    
    
}
