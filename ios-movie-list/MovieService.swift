//
//  Services.swift
//  ios-movie-list
//
//  Created by Artur Moura on 05/08/23.
//

import Foundation
import SwiftUI

func getData() async throws -> [Movie] {
    let authKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNTY2MzJjNzdkYTY2MDY3MjE1ZDAzMWVhYzRjM2EzMSIsInN1YiI6IjY0Y2VhMjU3ODUwOTBmMDE0NDViMzE1MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.fx1pPJVFe6PwaR4imdMD9TKllC7zDvmeCaRGzJxNKh4"
    let endpoint = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1"
    
    guard let url = URL(string: endpoint) else {
        throw Errors.invalidURL
    }
    
    var request = URLRequest(url: url)
    request.addValue("Bearer \(authKey)", forHTTPHeaderField: "Authorization")

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw Errors.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let movieResponses = try decoder.decode(MoviesResponse.self, from: data)
        return movieResponses.results
    }
    catch {
        throw Errors.invalidData
    }
}

struct Movie: Hashable, Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}

struct MoviesResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}

enum Errors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

