//
//  HomeView.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 02/12/2022.
//

import SwiftUI

struct HomeView: View {
  
  var platformMonitor: PlatformMonitor = .shared
  
  var body: some View {
    TabView {
      CharactersView()
        .tabItem {
          TabItemView(
            image: .charactersIcon,
            title: "Characters"
          )
        }
      FavoritesView()
        .tabItem {
          TabItemView(
            image: .favoritesIcon,
            title: "Favorites"
          )
        }
      EpisodesView()
        .tabItem {
          TabItemView(
            image: .episodesIcon,
            title: "Episodes"
          )
        }
    }
    .accentColor(platformMonitor.current == .ios ? .blue : .white)
  }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
