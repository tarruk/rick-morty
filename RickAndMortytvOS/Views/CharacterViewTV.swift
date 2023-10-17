//
//  CharacterViewTV.swift
//  RickAndMortytvOS
//
//  Created by Tarek Radovan on 20/09/2023.
//

import SwiftUI
import SwiftData

struct CharacterViewTV: View {
  
  @State var isFavorite: Bool = false
  @Query var favorites: [CharacterViewModel]
  @Environment(\.isPresented) var isPresented
  @Environment(\.rmService) var service
  let character: CharacterViewModel

  var addToFavoritesButtonAction: (() -> Void)?
  var platformMonitor: PlatformMonitor = .shared
  
  var body: some View {
    Button {
      addToFavoritesButtonAction?()
    } label: {
      HStack {
        HStack(alignment: .top) {
          LoadableImage(
            url: character.image ?? "",
            imageDescription: character.name ?? "",
            type: .tv
          )
          Text(character.name ?? "")
            .font(.title2)
            .foregroundColor(.black)
        }
        Spacer()
        Image(systemName: isFavorite ? "heart.fill" : "heart")
          .foregroundStyle(.red)
          .imageScale(.large)
      }
    }
    .padding()
    .cornerRadius(10)
    .onAppear {
      isFavorite = favorites.contains(where: {$0.id == character.id})
    }
    .onChange(of: favorites) { oldValue, newValue in
      isFavorite = newValue.contains(where: {$0.id == character.id})
    }
  }
}
