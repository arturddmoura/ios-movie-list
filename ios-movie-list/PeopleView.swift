//
//  PeopleView.swift
//  ios-movie-list
//
//  Created by Artur Moura on 05/08/23.
//

import SwiftUI

struct PeopleView: View {
    @State private var people: [Person] = []

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
                    }.padding(10)
                }.navigationTitle("FIAP Celebrities List")
            }
            .task{
                do {
                    people = try await getPeople()
                } catch {
                    print("Error: \(error)")
                    print("Unexpected error")
                }
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}
