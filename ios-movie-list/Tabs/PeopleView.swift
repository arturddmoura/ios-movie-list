//
//  PeopleView.swift
//  ios-movie-list
//
//  Created by Artur Moura on 05/08/23.
//

import SwiftUI
import SimpleToast
struct PeopleView: View {
    @State private var people: [Person] = []
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
                ForEach(people, id: \.self) { person in
                    VStack {
                        URLImage(urlString: "\(person.profilePath ?? "")", data: nil)
                        VStack(alignment: .leading) {
                            Text(person.name).font(.title3).fontWeight(.medium).multilineTextAlignment(.leading).padding(.bottom, 10)
                            Text("Known for: \(person.knownForDepartment ?? "Not informed")")
                                .multilineTextAlignment(.leading)
                                .lineLimit(6)
                        }
                        Button {
                            showToast.toggle()
                            database.addItem(title: person.name, description: "Known for: \(person.knownForDepartment ?? "Not informed")", image: "\(person.profilePath ?? "")")
                        } label: {
                            Text("Add to your favorites").padding(.top, 10)
                        }
                        .contentShape(Rectangle())
                    }.padding(10)
                }.navigationTitle("FIAP Celebrities List")
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
                    people = try await getPeople()
                } catch {
                    print("Error: \(error)")
                    print("Unexpected error")
                }
            }.environmentObject(database)
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView().environmentObject(InMemoryDatabase())
    }
}
