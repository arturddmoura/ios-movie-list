//
//  MovieView.swift
//  ios-movie-list
//
//  Created by Artur Moura on 05/08/23.
//

import SwiftUI
import SimpleToast

struct MovieView: View {
    @State private var movies: [Movie] = []
    @EnvironmentObject var database: InMemoryDatabase
    @State private var showToast = false
    @State private var value = 0

    private let toastOptions = SimpleToastOptions(
        hideAfter: 1,
        animation: .linear,
        modifierType: .slide
    )

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
                        }
                        Button {
                            showToast.toggle()
                            database.addItem(title: movie.title, description: movie.overview, image: "\(movie.posterPath ?? "")")
                        } label: {
                            Text("Add to your favorites").padding(.top, 10)
                        }
                        .contentShape(Rectangle())
                    }.padding(10)
                }.navigationTitle("FIAP Movie List")
            }
            .simpleToast(isPresented: $showToast, options: toastOptions) {
                Label("Added to your favourites.", systemImage: "burst.fill")
                .padding()
                .background(Color.green.opacity(0.8))
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .padding(.top)
            }
            .task{
                do {
                    movies = try await getData()
                } catch {
                    print("Unexpected error")
                }
            }
        }.environmentObject(database)
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView().environmentObject(InMemoryDatabase())

    }
}
