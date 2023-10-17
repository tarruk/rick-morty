//
//  CharactersView.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 01/12/2022.
//

import SwiftUI
import SwiftData

struct CharactersView: View {
  
  @Environment(\.rmService) private var service
  
  @Environment(\.modelContext) private var context
  @Query private var favorites: [CharacterViewModel]
  @State var characters: [CharacterViewModel] = []
  @State var isLoading: Bool = false
  
  var body: some View {
    NavigationView {
      ScrollView(.vertical) {
        LazyVStack {
          ForEach(characters) { character in
            if PlatformMonitor.shared.current == .ios {
              CharacterView(character: character, addToFavoritesButtonAction: {
                favoriteButtonWasPressed(character)
              })
            } else {
              CharacterViewTV(character: character, addToFavoritesButtonAction: {
                favoriteButtonWasPressed(character)
              })
            }
          }
        }
      }.task {
        await fetchCharacters()
      }
      .navigationTitle("Rick & Morty")
      .redacted(reason:  isLoading ? .placeholder : [])
    }
  }
  
  func fetchCharacters() async {
    isLoading = true
    let response = await service.fetchCharacters()
    isLoading = false
    switch response {
    case .success(let characters):
      self.characters = characters
    case .failure(let error):
      print(error.localizedDescription)
    }
  }
  
  func favoriteButtonWasPressed(_ character: CharacterViewModel) {
    if let favorite = favorites.first(where: { $0.id == character.id }) {
      removeFromFavorites(favorite)
    } else {
      addToFavorites(character)
    }
  }
  
  func addToFavorites(_ character: CharacterViewModel) {
    guard favorites.filter({ $0.id == character.id }).first == nil else {
      return
    }
    context.insert(character)
  }
  
  func removeFromFavorites(_ character: CharacterViewModel) {
    if let charToDelete = favorites.first(where: { character.id == $0.id}) {
      context.delete(charToDelete)
    }
  }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
        .environmentObject(RMService())
    }
}
