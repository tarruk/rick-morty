//
//  LoadableImage.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 01/12/2022.
//

import SwiftUI

struct LoadableImage: View {
    
  let url: String
  let imageDescription: String
  
  var body: some View {
    AsyncImage(url: URL(string: url)) { phrase in
      if let image = phrase.image {
        image
          .resizable()
          .frame(width: 50, height: 50)
          .cornerRadius(25)
          .shadow(radius: 5)
          .accessibilityElement()
          .accessibilityLabel(Text(imageDescription))
      } else {
        Image(systemName: "person.circle")
          .resizable()
          .frame(width: 50, height: 50)
          .cornerRadius(25)
          .shadow(radius: 5)
      }
    }
  }
}
