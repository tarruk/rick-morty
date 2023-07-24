//
//  RickAndMortyApp.swift
//  RickAndMortyApp
//
//  Created by Tarek Radovan on 22/02/2023.
//

import SwiftUI
import SwiftData

@main
struct rickandmortyApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
            .modelContainer(for: CharacterViewModel.self)
        }
    }
}
