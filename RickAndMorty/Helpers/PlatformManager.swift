//
//  PlatformManager.swift
//  RickAndMorty
//
//  Created by Tarek Radovan on 19/09/2023.
//

import Foundation

enum Platform {
  case ios
  case tvos
  case macos
  case watchos
}

final class PlatformMonitor {
  static let shared = PlatformMonitor()
  
  var current: Platform {
    #if os(tvOS)
      return .tvos
    #elseif os(watchOS)
      return .watchos
    #elseif os(macOS)
      return .macos
    #else
      return .ios
    #endif
  }
  
  private init() { }
}
