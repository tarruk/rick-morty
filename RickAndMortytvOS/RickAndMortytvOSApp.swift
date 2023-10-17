//
//  RickAndMortytvOSApp.swift
//  RickAndMortytvOS
//
//  Created by Tarek Radovan on 19/09/2023.
//

import SwiftUI

@main
struct RickAndMortytvOSApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
            .modelContainer(for: CharacterViewModel.self)
        }
    }
}
