//
//  CharacterView.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 01/12/2022.
//

import SwiftUI
import SwiftData

struct CharacterView: View {

  @Query var favorites: [CharacterViewModel]
  @Environment(\.isPresented) var isPresented
  @Environment(\.rmService) var service
  
  let character: CharacterViewModel
  var addToFavoritesButtonAction: (() -> Void)?
  var platformMonitor: PlatformMonitor = .shared
  
  @State var isFavorite: Bool = false
  
  var body: some View {
    HStack {
      LoadableImage(
        url: character.image ?? "",
        imageDescription: character.name ?? "",
        type: .phone
      )
      Text(character.name ?? "")
        .font(.headline)
      Spacer()
      if let addToFavoritesButtonAction {
        Button {
          Task {
            addToFavoritesButtonAction()
          }
        } label: {
          Image(systemName: isFavorite ? "heart.fill" : "heart")
            .foregroundStyle(.red)
        }
      }
    }
    .onAppear {
      isFavorite = favorites.contains(where: {$0.id == character.id})
    }
    .padding()
    .onChange(of: favorites) { oldValue, newValue in
      isFavorite = newValue.contains(where: {$0.id == character.id})
    }
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
