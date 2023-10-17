//
//  APIClient.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 11/08/2023.
//

import Foundation

final class APIClient {
  
  private let basePath: String
  
  init(basePath: String = "https://rickandmortyapi.com/api/") {
    self.basePath = basePath
  }
  
  func fetch<T: Decodable>(type: T.Type, endpoint: Endpoint) async -> Result<T, Error> {
    guard let url = URL(string: basePath + endpoint.rawValue) else {
      return .failure(NetworkingError.badURL)
    }
    
    var request = URLRequest(url: url)
    request.setValue("*/*", forHTTPHeaderField: "Accept")
  
    do {
      let (data, response) = try await URLSession.shared.data(for: request)
      guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        return .failure(NetworkingError.badRequest )
      }
      let dataModel = try JSONDecoder().decode(T.self, from: data)
      return .success(dataModel)
    } catch let error {
      return .failure(error)
    }
  }
}
