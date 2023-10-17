//
//  RMService.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 01/12/2022.
//

import Foundation
import Combine
import SwiftUI

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

protocol RMServiceProtocol: ObservableObject {
  func fetchCharacters() async -> Result<[CharacterViewModel], Error>
  func fetchEpisodes() async -> Result<[Episode], Error>
  func fetchFavorites() async -> Result<[Character], Error>
}


final class RMService: RMServiceProtocol {
  
  private let client: APIClient
  
  init(client: APIClient = APIClient()) {
    self.client = client
  }
 
  func fetchCharacters() async -> Result<[CharacterViewModel], Error> {
    let result = await client.fetch(type: CharactersResponse.self, endpoint: .character)
    
    switch result {
    case .success(let charactersResponse):
      return .success(charactersResponse.characters.map {
        CharacterViewModel(character: $0)
      })
    case .failure(let error):
      return .failure(error)
    }
  }
  
  func fetchEpisodes() async -> Result<[Episode], Error> {
    let result = await client.fetch(type: EpisodesResponse.self, endpoint: .episode)
    switch result {
    case .success(let episodesResponse):
      return .success(episodesResponse.episodes)
    case .failure(let error):
      return .failure(error)
    }
  }
  
  func fetchFavorites() async -> Result<[Character], Error> {
    let result = await client.fetch(type: [Character].self, endpoint: .favorites)
    switch result {
    case .success(let favorites):
      return .success(favorites)
    case .failure(let error):
      return .failure(error)
    }
  }
}

final class RMServiceMock: RMServiceProtocol {
  func fetchCharacters() async -> Result<[CharacterViewModel], Error> {
    return .success([
      CharacterViewModel(
        character: Character(id: 0, name: "Pickle Rick", image: nil)
      ),
      CharacterViewModel(
        character: Character(id: 1, name: "One eye Morty", image: nil)
      ),
      CharacterViewModel(
        character: Character(id: 2, name: "Bodybuilder Jerry", image: nil)
      )
    ])
  }
  
  func fetchEpisodes() async -> Result<[Episode], Error> {
    return .success([])
  }
  
  func fetchFavorites() async -> Result<[Character], Error> {
    return .success([
      Character(id: 1, name: "One eye Morty", image: nil),
      Character(id: 2, name: "Bodybuilder Jerry", image: nil)
    ])
  }
}

struct RMServiceValue: EnvironmentKey {
  static var defaultValue: any RMServiceProtocol = RMService()
}

struct RMServiceMockValue: EnvironmentKey {
  static var defaultValue: any RMServiceProtocol = RMServiceMock()
}

extension EnvironmentValues {
  var rmService: any RMServiceProtocol {
    get { self[RMServiceValue.self] }
    set { self[RMServiceValue.self] = newValue }
  }
  
  var rmServiceMock: any RMServiceProtocol {
    get { self[RMServiceMockValue.self] }
    set { self[RMServiceMockValue.self] = newValue }
  }
}

