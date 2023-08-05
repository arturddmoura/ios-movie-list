//
//  TopBar.swift
//  ios-movie-list
//
//  Created by Artur Moura on 05/08/23.
//

import SwiftUI

struct TopBar: View {
    var body: some View {
        VStack {
            Text("FIAP Movie List")
                .font(.title)
                .padding()
            Spacer()
            
        }
        .navigationTitle("Top Bar App")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar()
    }
}
