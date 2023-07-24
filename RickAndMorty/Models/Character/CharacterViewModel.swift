//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 24/07/2023.
//

import Foundation
import SwiftData

@Model
final class CharacterViewModel: Identifiable {
  var id: Int?
  var name: String?
  var image: String?
  
  init(character: Character) {
    self.id = character.id
    self.name = character.name
    self.image = character.image
  }
  
}
