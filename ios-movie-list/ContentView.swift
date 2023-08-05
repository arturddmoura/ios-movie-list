//
//  ContentView.swift
//  ios-movie-list
//
//  Created by Artur Moura on 05/08/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .tv
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    TabView(selection: $selectedTab) {
                        MovieView()
                            .padding(.bottom, 80)
                            .tag(Tab.tv)
                        PeopleView()
                            .padding(.bottom, 80)
                            .tag(Tab.person)
                        FavoritesView()
                            .padding(.bottom, 80)
                            .tag(Tab.heart)
                    }
                }
                VStack {
                    Spacer()
                    NavigationBar(selectedTab: $selectedTab)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
