//
//  FavoritesView.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 02/12/2022.
//

import SwiftUI

struct FavoritesView: View {
  
  @EnvironmentObject var service: RMService

  var body: some View {
    NavigationView {
      ScrollView(.vertical) {
        VStack {
          ForEach(service.favorites) { character in
            CharacterView(
              character: character,
              type: .favorite
            )
          }
        }
      }.task {
        try? await service.fetchFavorites()
      }
      .navigationTitle("Favorites")
      .redacted(reason:  service.isLoading ? .placeholder : [])
    }
    
  }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
