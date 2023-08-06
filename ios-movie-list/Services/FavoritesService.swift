//
//  FavoritesService.swift
//  ios-movie-list
//
//  Created by Artur Moura on 05/08/23.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var image: String
}

class InMemoryDatabase: ObservableObject {
    @Published var items: [Item] = []

    func addItem(title: String, description: String, image: String) {
        let newItem = Item(title: title, description: description, image: image)
        items.append(newItem)
    }

    func getAllItems() -> [Item] {
        return items
    }

    func deleteItem(for id: UUID) {
        items.removeAll(where: { $0.id == id })
    }
}
