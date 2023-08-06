//
//  FavoritesView.swift
//  ios-movie-list
//
//  Created by Artur Moura on 05/08/23.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var database: InMemoryDatabase

    var body: some View {
        NavigationView {
            if database.getAllItems().isEmpty {
                List {
                    VStack {
                        Text("Your favorites list is empty.")
                            .foregroundColor(.gray)
                            .padding(.top, 20)
                        Spacer()
                    }
                }.navigationBarTitle("FIAP Favorites")
            } else {
                List(database.getAllItems()) { item in
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            URLImage(urlString: item.image, data: nil)
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom, 10)
                                Text(item.description)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(6)
                            }
                        }
                        Button {
                            database.deleteItem(for: item.id)
                        } label: {
                            Text("Remove from your favorites")
                                .padding(.top, 10)
                        }
                        .contentShape(Rectangle())
                    }
                }
                .navigationBarTitle("FIAP Favorites")
            }
        }
        .environmentObject(database)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView().environmentObject(InMemoryDatabase())
    }
}


