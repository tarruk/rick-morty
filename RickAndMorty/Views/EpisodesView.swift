//
//  EpisodesView.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 02/12/2022.
//

import SwiftUI

struct EpisodesView: View {
  @EnvironmentObject var service: RMService
  
  var body: some View {
    List {
      ForEach(service.episodes) { episode in
        Text(episode.name ?? "")
          .font(.headline)
          .fontDesign(.monospaced)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding()
      }
    }.task {
      try? await service.fetchEpisodes()
    }
    .redacted(reason:  service.isLoading ? .placeholder : [])
  }
}

struct EpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesView()
    }
}
