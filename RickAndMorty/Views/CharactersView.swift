//
//  CharactersView.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 01/12/2022.
//

import SwiftUI
import SwiftData

struct CharactersView: View {

  @EnvironmentObject var service: RMService
  @Environment(\.modelContext) private var context
  @Query private var favorites: [CharacterViewModel]
  
  var body: some View {
    NavigationView {
      ScrollView(.vertical) {
        VStack {
          ForEach(service.characters) { character in
            CharacterView(
              character: character,
              addToFavoritesButtonAction: {
                addToFavorites(character)
              }
            )
          }
        }
      }.task {
        try? await service.fetchCharacters()
      }
      .navigationTitle("Rick & Morty")
      .redacted(reason:  service.isLoading ? .placeholder : [])
    }
  }
  
  func addToFavorites(_ character: CharacterViewModel) {
    guard favorites.filter({ $0.id == character.id }).first == nil else {
      return
    }
    context.insert(character)
  }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
        .environmentObject(RMService())
    }
}
