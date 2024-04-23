//
//  MovieDetailModel.swift
//  N2FLIX
//
//  Created by 쌩 on 4/23/24.
//

import Foundation

// MARK: - MovieDetailModel
struct MovieDetailModel: Codable {
    let adult: Bool
    let genres: [Genre]
    let id: Int
    let overview: String
    let posterPath, releaseDate: String
    let runtime: Int
    let status, title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case adult, genres, id, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime, status, title
        case voteAverage = "vote_average"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
