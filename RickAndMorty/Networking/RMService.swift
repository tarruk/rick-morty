//
//  RMService.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 01/12/2022.
//

import Foundation
import Combine

enum HTTPMethod: String {
  case GET
  case POST
  case PUT
  case DELETE
}

enum MYMEType: String {
    case JSON = "application/json"
}

enum HTTPHeaders: String {
  case contentType = "Content-Type"
}

enum NetworkingError: Error {
  case objectNotFound
  case serverError
  case decodeError
  case badRequest
  case badURL
}

enum Endpoint: String {
  case character
  case episode
  case favorites
  case deleteFavorite
  case addFavorite
}

final class RMService: ObservableObject {
  
  private var isLoadingPublisher = CurrentValueSubject<Bool, Never>(false)
  @Published private(set) var isLoading: Bool = false
  
  var basePath: String = "https://rickandmortyapi.com/api/"
  
  private var favoritesPublisher = CurrentValueSubject<[Character], Never>([])
  @Published private(set) var favorites = [Character]()
  
  private var charactersPublisher = CurrentValueSubject<[Character], Never>([])
  @Published private(set) var characters = [Character]()
  
  private var episodesPublisher = CurrentValueSubject<[Episode], Never>([])
  @Published private(set) var episodes = [Episode]()
  
  private var errorPublisher = CurrentValueSubject<String, Never>("")
  @Published private(set) var errorMessage = ""
  
  init() {
    
    charactersPublisher
      .receive(on: DispatchQueue.main)
      .assign(to: &$characters)
    
    episodesPublisher
      .receive(on: DispatchQueue.main)
      .assign(to: &$episodes)
    
    favoritesPublisher
      .receive(on: DispatchQueue.main)
      .assign(to: &$favorites)
    
    isLoadingPublisher
      .receive(on: DispatchQueue.main)
      .assign(to: &$isLoading)
    
    errorPublisher
      .receive(on: DispatchQueue.main)
      .assign(to: &$errorMessage)
  }
  
  private func fetch<T: Decodable>(type: T.Type, endpoint: Endpoint) async throws -> Result<T, Error> {
    guard let url = URL(string: basePath + endpoint.rawValue) else {
      return .failure(NetworkingError.badURL)
    }
    
    var request = URLRequest(url: url)
    request.setValue("*/*", forHTTPHeaderField: "Accept")
  
    let (data, response) = try await URLSession.shared.data(for: request)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      return .failure(NetworkingError.badRequest )
    }
    
    do {
      let dataModel = try JSONDecoder().decode(T.self, from: data)
      return .success(dataModel)
    } catch let error {
      return .failure(error)
    }

  }
  
  private func send<T: Encodable>(object: T, method: HTTPMethod, endpoint: Endpoint) async throws -> Result<Bool,Error> {
    guard
      let url = URL(string: basePath+endpoint.rawValue) else {
      return .failure(NetworkingError.badURL)
    }
    var request: URLRequest = URLRequest(url: url)
    request.httpMethod = method.rawValue
    
    request.addValue(
      MYMEType.JSON.rawValue,
      forHTTPHeaderField: HTTPHeaders.contentType.rawValue
    )
    request.httpBody = try? JSONEncoder().encode(object)
    
    let (_, response) = try await URLSession.shared.data(for: request)
    
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      return .failure(NetworkingError.badRequest)
    }
    
    return .success(true)
  }
  
  func fetchCharacters() async throws {
    isLoadingPublisher.send(true)
    let result = try await fetch(type: CharactersResponse.self, endpoint: .character)
    isLoadingPublisher.send(false)
    switch result {
    case .success(let charactersResponse):
      charactersPublisher.send(charactersResponse.characters)
    case .failure(let error):
      errorPublisher.send(error.localizedDescription)
    }
  }
  
  func saveFavoriteCharacter(_ character: Character) async throws {
    let result = try await send(object: character, method: .POST, endpoint: .addFavorite)
    switch result {
    case .success(_ ):
      try await fetchFavorites()
    case .failure(let error):
      errorPublisher.send(error.localizedDescription)
    }
  }
  
  func deleteFavoriteCharacter(_ character: Character) async throws {
    let result = try await send(object: character, method: .DELETE, endpoint: .deleteFavorite)
    switch result {
    case .success(_ ):
      try await fetchFavorites()
    case .failure(let error):
      errorPublisher.send(error.localizedDescription)
    }
  }
  
  func fetchEpisodes() async throws {
    isLoadingPublisher.send(true)
   let result = try await fetch(type: EpisodesResponse.self, endpoint: .episode)
    isLoadingPublisher.send(false)
    switch result {
    case .success(let episodesResponse):
      episodesPublisher.send(episodesResponse.episodes)
    case .failure(let error):
      errorPublisher.send(error.localizedDescription)
    }
  }
  
  func fetchFavorites() async throws {
    isLoadingPublisher.send(true)
    let result = try await fetch(type: [Character].self, endpoint: .favorites)
    isLoadingPublisher.send(false)
    switch result {
    case .success(let favorites):
      favoritesPublisher.send(favorites)
    case .failure(let error):
      errorPublisher.send(error.localizedDescription)
    }
  }
}
