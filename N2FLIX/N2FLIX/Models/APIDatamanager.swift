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
    
    func readAPI(_ category : String){
        if let url = URL(string: "https://api.themoviedb.org/3/movie/\(category)") {
            let categories: [String] = ["now_playing", "popular", "top_rated", "upcoming"]
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            let queryItems: [URLQueryItem] = categories.contains(category) != false ? [
              URLQueryItem(name: "language", value: "ko-kr"),
            ] : [URLQueryItem(name: "language", value: "ko-kr"),
                 URLQueryItem(name: "page", value: "1"),]
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
                    // Mark: category가 now_playing 같은 카테고리인지, movie id 인지에 따라 다른 모델이용 디코딩
                    if categories.contains(category) {
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
//                            print(movieDetail)
                        } catch {
                            print("Decode Error: \(error)")
                        }
                    }
                    
                }
                
            }
            task.resume()
        }
    }
}
