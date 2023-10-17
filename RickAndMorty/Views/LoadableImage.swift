//
//  LoadableImage.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 01/12/2022.
//

import SwiftUI

enum ImageType {
  case phone
  case tv
  
  var width: CGFloat {
    switch self {
    case .phone:
      return 50
    case .tv:
      return 500
    }
  }
  
  var height: CGFloat {
    switch self {
    case .phone:
      return 50
    case .tv:
      return 300
    }
  }
}

struct LoadableImage: View {
    
  let url: String
  let imageDescription: String
  let type: ImageType
  
  var body: some View {
    AsyncImage(url: URL(string: url)) { phrase in
      if let image = phrase.image {
        image
          .resizable()
          .frame(width: type.width, height: type.height)
          .cornerRadius(type == .phone ? type.height / 2 : 10)
          .shadow(radius: type.height / 2)
          .accessibilityElement()
          .accessibilityLabel(Text(imageDescription))
      } else {
        Image(systemName: "person.circle")
          .resizable()
          .frame(width: type.width, height: type.height)
          .cornerRadius(type == .phone ? type.height / 2 : 10)
          .shadow(radius: type.height / 2)
      }
    }
  }
}
