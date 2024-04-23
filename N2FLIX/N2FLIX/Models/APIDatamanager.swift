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
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            let queryItems: [URLQueryItem] = [
              URLQueryItem(name: "language", value: "ko-kr"),
              URLQueryItem(name: "page", value: "1"),
            ]
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
                    do {
                        let Movies = try JSONDecoder().decode(MovieData.self, from: data)
                        self.Movie = Movies.results
                        print(self.Movie)
                    } catch {
                        print("Decode Error: \(error)")
                    }
                }
                
            }
            task.resume()
        }
    }
}
