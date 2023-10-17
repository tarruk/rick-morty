//
//  TabItemView.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 21/09/2023.
//

import SwiftUI

struct TabItemView: View {
  
  let image: Image
  let title: String
  
  var body: some View {
    VStack {
      image
        .renderingMode(.template)
        .resizable()
        .frame(width: 25, height: 25)
      Text(title)
        .font(.caption)
        .foregroundColor(.black)
    }
  }
}
