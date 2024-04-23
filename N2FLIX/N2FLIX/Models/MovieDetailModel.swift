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
    let popularity: Double
    let posterPath, releaseDate: String
    let revenue, runtime: Int
    let status, tagline, title: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult, genres, id, overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime, status, tagline, title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
