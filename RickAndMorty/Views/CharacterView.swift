//
//  CharacterView.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 01/12/2022.
//

import SwiftUI

enum CharacterType {
  case favorite
  case normal
  
  var buttonTitle: String {
    switch self {
    case .favorite:
      return "Delete from favorites"
    case .normal:
      return "Add to favorites"
    }
  }
}

struct CharacterView: View {

  @EnvironmentObject var service: RMService
  let character: Character
  let type: CharacterType
  
  var body: some View {
    HStack {
      LoadableImage(
        url: character.image ?? "",
        imageDescription: character.name ?? "")
      Text(character.name ?? "")
        .font(.headline)
      Spacer()
      Button {
        Task {
          switch type {
          case .normal:
            try? await service.saveFavoriteCharacter(character)
          case .favorite:
            try? await service.deleteFavoriteCharacter(character)
          }
        }
      } label: {
        Text(type.buttonTitle)
          .font(.caption)
      }

      
    }.padding()
  }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
      CharacterView(character: Character(
        id: 0,
        name: "Rick",
        image: ""
      ), type: .favorite)
    }
}
