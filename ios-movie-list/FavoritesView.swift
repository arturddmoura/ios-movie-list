//
//  FavoritesView.swift
//  ios-movie-list
//
//  Created by Artur Moura on 05/08/23.
//

import SwiftUI
import SimpleToast

struct FavoritesView: View {
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
                            showToast.toggle()
                            database.deleteItem(for: item.id)
                        } label: {
                            Text("Remove from your favorites")
                                .padding(.top, 10)
                        }
                        .contentShape(Rectangle())
                    }
                }
                .simpleToast(isPresented: $showToast, options: toastOptions) {
                    Label("Removed from your favourites.", systemImage: "minus.circle.fill")
                    .padding()
                    .background(Color.red.opacity(0.8))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .padding(.top)
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


