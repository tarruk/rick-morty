//
//  CharacterView.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 01/12/2022.
//

import SwiftUI
import SwiftData

struct CharacterView: View {

  @EnvironmentObject var service: RMService
  let character: CharacterViewModel
  var addToFavoritesButtonAction: (() -> Void)?
  
  var body: some View {
    HStack {
      LoadableImage(
        url: character.image ?? "",
        imageDescription: character.name ?? "")
      Text(character.name ?? "")
        .font(.headline)
      Spacer()
      if let addToFavoritesButtonAction {
        Button {
          Task {
            addToFavoritesButtonAction()
          }
        } label: {
          Text("Add to favorites")
            .font(.caption)
        }
      }
    }.padding()
  }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
      CharacterView(character: CharacterViewModel(character: Character(
        id: 0,
        name: "Rick",
        image: ""
      )))
    }
}
