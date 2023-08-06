//
//  ios_movie_listApp.swift
//  ios-movie-list
//
//  Created by Artur Moura on 05/08/23.
//

import SwiftUI

@main
struct ios_movie_listApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(InMemoryDatabase())
        }
    }
}
