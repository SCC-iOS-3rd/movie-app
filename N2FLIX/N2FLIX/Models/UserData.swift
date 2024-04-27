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

struct UserWish {
    let title: String
    let posterPath: String
    let id: Int
}

struct UserData {
    let userEmail : String
    let userPW : String
    var userNickName : String
}

