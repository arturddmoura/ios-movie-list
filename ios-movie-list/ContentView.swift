//
//  ContentView.swift
//  ios-movie-list
//
//  Created by Artur Moura on 05/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var movies: [Movie] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(movies, id: \.self) { movie in
                    VStack {
                        URLImage(urlString: "https://image.tmdb.org/t/p/w1280/\(movie.posterPath ?? "")", data: nil)
                        VStack {
                            Text(movie.title).font(.title3).fontWeight(.medium).multilineTextAlignment(.center).padding(10)
                            Text(movie.overview)
                                .multilineTextAlignment(.leading)
                                .lineLimit(6)
                        }
                    }.padding(10)
                }.navigationTitle("FIAP Movie List")
            }
            .task{
                do {
                    movies = try await getData()
                } catch {
                    print("Unexpected error")
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
