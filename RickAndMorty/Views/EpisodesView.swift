//
//  EpisodesView.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 02/12/2022.
//

import SwiftUI

struct EpisodesView: View {
  @Environment(\.rmService) var service
  @State var episodes: [Episode] = []
  @State var isLoading: Bool = false
  private let platformMonitor: PlatformMonitor
  
  init(
    episodes: [Episode] = [],
    isLoading: Bool = false,
    platformMonitor: PlatformMonitor = .shared
  ) {
    self.episodes = episodes
    self.isLoading = isLoading
    self.platformMonitor = platformMonitor
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(episodes) { episode in
          if let episodeName = episode.name {
            Button {
              // On row pressed
            } label: {
              Text(episodeName)
                .font(.headline)
                .fontDesign(.monospaced)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
          }
         
        }
      }.task {
        await fetchEpisodes()
      }
      .redacted(reason: isLoading ? .placeholder : [])
      .navigationTitle("Episodes View")
    }
  }
  
  func fetchEpisodes() async {
    isLoading = true
    let response = await service.fetchEpisodes()
    isLoading = false
    
    switch response {
    case .success(let episodes):
      self.episodes = episodes
    case .failure(let error):
      print(error.localizedDescription)
    }
  }
}

struct EpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesView()
    }
}
