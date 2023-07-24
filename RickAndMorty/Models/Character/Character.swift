//
//  Character.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 01/12/2022.
//

import Foundation

struct Character: Codable {
  let id: Int?
  let name: String?
  let image: String?
}

struct ResponseInfo: Codable {
  let count: Int
  let pages: Int
  let next: String?
  let prev: String?
}

struct CharactersResponse: Codable {
  let info: ResponseInfo
  let characters: [Character]
  
  enum CodingKeys: String, CodingKey {
    case info
    case characters = "results"
  }
}
