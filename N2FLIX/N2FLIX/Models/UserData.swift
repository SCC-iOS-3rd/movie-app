//
//  UserData.swift
//  N2FLIX
//
//  Created by /Chynmn/M1 pro—̳͟͞͞♡ on 4/22/24.
//

import Foundation

struct Movie: Codable {
    let title: String
    let director: String
    let releaseYear: Int
    
}

struct Booking: Codable {
    let movieTitle: String
    let screeningTime: String
    let numberOfPeople: Int
    let paymentAmount: Int
    
}

struct UserData {
    static var shared = UserData()
    
    private let userDefaults = UserDefaults.standard
    
    private let defaultProfileImageName = "defaultImage"
    
    var isLoggedIn: Bool {
        return userDefaults.bool(forKey: "isLoggedIn")
    }
    
    var userID: String? {
        get { return userDefaults.string(forKey: "userID") }
        set { userDefaults.set(newValue, forKey: "userID") }
    }
    
    var password: String? {
        get { return userDefaults.string(forKey: "password") }
        set { userDefaults.set(newValue, forKey: "password") }
    }
    
    var userNickName: String? {
        get { return userDefaults.string(forKey: "userNickName") }
        set { userDefaults.set(newValue, forKey: "userNickName") }
    }
    
    var ticketList: [Booking] {
        get {
            guard let data = userDefaults.data(forKey: "bookedMovies"),
                  let bookings = try? JSONDecoder().decode([Booking].self, from: data) else {
                return []
            }
            return bookings
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            userDefaults.set(data, forKey: "bookedMovies")
        }
    }
    
    var wishList: [Movie] {
        get {
            guard let data = userDefaults.data(forKey: "wishList"),
                  let movies = try? JSONDecoder().decode([Movie].self, from: data) else {
                return []
            }
            return movies
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            userDefaults.set(data, forKey: "wishList")
        }
    }
    
    private init() {
        // Singleton pattern을 따라 private으로 초기화
    }
    
    mutating func login(userID: String, password: String, userNickName: String) {
        self.userID = userID
        self.password = password
        self.userNickName = userNickName
        userDefaults.set(true, forKey: "isLoggedIn")
    }
    
    func logout() {
        userDefaults.set(false, forKey: "isLoggedIn")
        // 다른 사용자 정보 초기화 등 필요한 작업 수행
   }
}
