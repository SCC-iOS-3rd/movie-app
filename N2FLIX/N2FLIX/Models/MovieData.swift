//
//  MovieData.swift
//  N2FLIX
//
//  Created by /Chynmn/M1 pro—̳͟͞͞♡ on 4/22/24.
//

import Foundation
import UIKit
struct MovieData : Codable {
    let results: [Result]
    enum CodingKeys: String, CodingKey {
            case results
        }
}

struct Result : Codable {
    let adult: Bool
    let genreIDS: [Int]
    let id: Int
    let overview : String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case genreIDS = "genre_ids"
        case id
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

