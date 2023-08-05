//
//  PeopleService.swift
//  ios-movie-list
//
//  Created by Artur Moura on 05/08/23.
//

import Foundation
import SwiftUI

func getPeople() async throws -> [Person] {
    let authKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNTY2MzJjNzdkYTY2MDY3MjE1ZDAzMWVhYzRjM2EzMSIsInN1YiI6IjY0Y2VhMjU3ODUwOTBmMDE0NDViMzE1MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.fx1pPJVFe6PwaR4imdMD9TKllC7zDvmeCaRGzJxNKh4"
    let endpoint = "https://api.themoviedb.org/3/trending/person/day?language=en-US"
    
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

        let peopleResponse = try decoder.decode(PeopleResponse.self, from: data)
        let first10Results = Array(peopleResponse.results.prefix(10))
        return first10Results
    }
    catch {
        throw Errors.invalidData
    }
}

struct Person: Hashable, Codable {
    let adult: Bool?
    let id: Int
    let name: String
    let originalName: String?
    let mediaType: String?
    let popularity: Double?
    let gender: Int?
    let knownForDepartment: String?
    let profilePath: String?
    let knownFor: [KnownFor]?

    struct KnownFor: Hashable, Codable {
        let adult: Bool?
        let backdropPath: String?
        let id: Int?
        let title: String?
        let originalLanguage: String?
        let originalTitle: String?
        let overview: String?
        let posterPath: String?
        let mediaType: String?
        let genreIds: [Int]?
        let popularity: Double?
        let releaseDate: String?
        let video: Bool?
        let voteAverage: Double?
        let voteCount: Int?
    }
}

struct PeopleResponse: Codable {
    let page: Int?
    let results: [Person]
    let totalPages: Int?
    let totalResults: Int?
}
