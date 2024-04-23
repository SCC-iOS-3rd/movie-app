//
//  APIDatamanager.swift
//  N2FLIX
//
//  Created by 송정훈 on 4/23/24.
//

import UIKit

// Use Plist for get API_KEY
private var apiKey: String {
    get {
        // 1
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            fatalError("Couldn't find file 'Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "MovieAPIKey") as? String else {
            fatalError("Couldn't find key 'MovieAPIKey' in 'Info.plist'.")
        }
        return value
    }
}

private var Token: String {
    get {
        // 1
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            fatalError("Couldn't find file 'Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "MovieClientToken") as? String else {
            fatalError("Couldn't find key 'MovieClientToken' in 'Info.plist'.")
        }
        return value
    }
}

class APIDatamanager {
    var Movie : [Result] = []
    var movieDetailVC = MovieDetailVC()
    
    let url = URL(string: "https://api.themoviedb.org/3/search/movie")!
    func readAPI(word keyWord: String, forSearch search: Bool){
        let categories: [String] = ["now_playing", "popular", "top_rated", "upcoming"]
        let baseUrl: String = search ? "https://api.themoviedb.org/3/search/movie" : "https://api.themoviedb.org/3/movie/\(keyWord)"
        if let url = URL(string: "\(baseUrl)") {
            print(url)
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            var queryItems: [URLQueryItem] = categories.contains(keyWord) != false ? [
                URLQueryItem(name: "language", value: "ko-kr"),
            ] : [URLQueryItem(name: "language", value: "ko-kr"),
                 URLQueryItem(name: "page", value: "1"),]
            // Mark: search == true일때 query의 value에 검색할 쿼리 입력.
            if search {
                queryItems = [URLQueryItem(name: "query", value: keyWord),
                              URLQueryItem(name: "include_adult", value: "false"),
                              URLQueryItem(name: "language", value: "en-US"),
                              URLQueryItem(name: "page", value: "1")]
            }
            components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
            
            var request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = [
                "accept": "application/json",
                "Authorization": "Bearer \(Token)"
            ]
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                //여기서 에러 체크 및 받은 데이터 가공하여 사용
                if let error = error {
                    print("\(error)")
                }else if let data = data {
                    if search {
                        do {
                            let Movies =  try JSONDecoder().decode(MovieData.self, from: data)
                            self.Movie = Movies.results
                            print(self.Movie)
                        } catch {
                            print("Decode Error: \(error)")
                        }
                    } else {
                        if categories.contains(keyWord) {
                            do {
                                let Movies =  try JSONDecoder().decode(MovieData.self, from: data)
                                self.Movie = Movies.results
                                print(self.Movie)
                            } catch {
                                print("Decode Error: \(error)")
                            }
                        } else {
                            do {
                                let movieDetail =  try JSONDecoder().decode(MovieDetailModel.self, from: data)
                                self.movieDetailVC.movieDetailModel = movieDetail
                                print(movieDetail)
                            } catch {
                                print("Decode Error: \(error)")
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
