//
//  FavoritesView.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 02/12/2022.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
  
  @Query private var favorites: [CharacterViewModel]
  @Environment(\.modelContext) private var context
  
  var body: some View {
    NavigationView {
      List {
        ForEach(favorites) { character in
          CharacterView(character: character)
        }
        .onDelete { indexes in
          for index in indexes {
            deleteFromFavorites(favorites[index])
          }
        }
      }
      .navigationTitle("Favorites")
    }
  }
  
  func deleteFromFavorites(_ character: CharacterViewModel) {
    context.delete(character)
  }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
