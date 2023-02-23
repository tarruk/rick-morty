//
//  Episode.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 02/12/2022.
//

import Foundation

struct Episode: Codable, Identifiable {
  var id: Int
  var name: String?
  var url: String?
}

struct EpisodesResponse: Codable {
  let info: ResponseInfo
  let episodes: [Episode]
  
  enum CodingKeys: String, CodingKey {
    case info
    case episodes = "results"
  }
}
