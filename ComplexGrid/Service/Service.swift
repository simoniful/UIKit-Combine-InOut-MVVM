//
//  Service.swift
//  ComplexGrid
//
//  Created by Sang hun Lee on 2023/07/25.
//

import Foundation

final class Service {
  // MARK: https://api.themoviedb.org/3/search/movie?api_key=c7e0151847ca19a98e490c58ebee5a8a&language=en-US&page=1&query=빅뱅&include_adult=false
  let endpoint = "https://api.themoviedb.org/3/search/movie"
  let api_key = "c7e0151847ca19a98e490c58ebee5a8a"
  let language = "ko-KR"
  let page = 1
  let query = ""
  let include_adult = false
  
  static let imageBase = "https://image.tmdb.org/t/p/original/"
  
  static var sharedInstance = Service()
  private init() {}
  
  func fetchFilms(
    for keyWordSearch: String,
    completionHandler: @escaping ([Result]) -> Void
  ) {
    print("호출")
    guard let encodedKeyword = keyWordSearch.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
    let urlStr = endpoint + "?api_key=" + api_key + "&language=" + language + "&page=" + "\(page)" + "&query=" + encodedKeyword + "&include_adult=" + "\(include_adult)"
    guard let endpoint = URL(
      string: urlStr
    ) else { return }
    
    let task = URLSession.shared.dataTask(with: endpoint, completionHandler: { (data, response, error) in
      if let error = error {
        print("Error with fetching films: \(error)")
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
        print("Error with the response, unexpected status code: \(String(describing: response))")
        return
      }
      
      if let data = data,
         let filmSummary = try? JSONDecoder().decode(Response.self, from: data) {
        print(data)
        completionHandler(filmSummary.results ?? [])
      }
    })
    task.resume()
  }
}
