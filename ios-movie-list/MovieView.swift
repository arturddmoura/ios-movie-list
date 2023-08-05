//
//  MovieView.swift
//  ios-movie-list
//
//  Created by Artur Moura on 05/08/23.
//

import SwiftUI

struct MovieView: View {
    @State private var movies: [Movie] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(movies, id: \.self) { movie in
                    VStack(alignment: .leading) {
                        URLImage(urlString: "\(movie.posterPath ?? "")", data: nil)
                        VStack(alignment: .leading) {
                            Text(movie.title).font(.title3).fontWeight(.medium).multilineTextAlignment(.leading).padding(.bottom, 10)
                            Text(movie.overview)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                                .lineLimit(6)
                            Button {
                                print("\(movie.title) \(movie.overview) \(movie.posterPath ?? "")")
                            } label: {
                                Text("Add to favorites")
                                    .padding(.top, 20)
                            }
                            .contentShape(Rectangle())
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

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView()
    }
}
