//
//  CharactersView.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 01/12/2022.
//

import SwiftUI

struct CharactersView: View {

  @EnvironmentObject var service: RMService

  var body: some View {
    NavigationView {
      ScrollView(.vertical) {
        VStack {
          ForEach(service.characters) { character in
            CharacterView(
              character: character,
              type: .normal
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
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
        .environmentObject(RMService())
    }
}
