//
//  HomeView.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 02/12/2022.
//

import SwiftUI

struct HomeView: View {
  
  @StateObject private var service = RMService()
  
  var body: some View {
    TabView {
      CharactersView()
        .environmentObject(service)
        .tabItem {
          Image.charactersIcon
            .renderingMode(.template)
            .resizable()
            .frame(maxWidth: 25, maxHeight: 25)
            Text("Characters")
        }
      FavoritesView()
        .environmentObject(service)
        .tabItem {
          Image.favoritesIcon
            .renderingMode(.template)
            .resizable()
            .frame(width: 25, height: 25)
          Text("Favorites")
            .font(.caption)
            .foregroundColor(.black)
        }
      EpisodesView()
        .environmentObject(service)
        .tabItem {
          Image.episodesIcon
            .renderingMode(.template)
            .resizable()
            .frame(width: 25, height: 25)
          Text("Episodes")
            .font(.caption)
            .foregroundColor(.black)
        }
    }.accentColor(.blue)
  }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
