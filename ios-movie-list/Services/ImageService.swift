//
//  ImageService.swift
//  ios-movie-list
//
//  Created by Artur Moura on 05/08/23.
//

import Foundation
import SwiftUI

struct URLImage: View {
    let urlString: String
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .frame(width: 140, height: 200)
                .aspectRatio(contentMode: .fill)
                .padding(.bottom, 10)
        }
        else {
            Image(systemName: "video")
                .resizable()
                .frame(width: 140, height: 200)
                .aspectRatio(contentMode: .fill)
                .padding(.bottom, 10)
                .onAppear {
                    fetchImage()
                }
        }
    }
    
    private func fetchImage() {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w1280/" + urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in self.data = data
        }
        task.resume()
    }
}
