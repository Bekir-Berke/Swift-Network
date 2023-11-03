//
//  GitHubUser.swift
//  Swift-Network
//
//  Created by Bekir Berke Yılmaz on 2.11.2023.
//

import Foundation
struct GitHubUser: Codable{
    let login: String
    let avatarUrl: String
    let bio: String
}
enum GHError: Error{
    case invalidURL
    case invalidResponse
    case invalidData
}
func getUser() async throws -> GitHubUser{
    let endpoint = "https://api.github.com/users/Bekir-Berke"
    guard let url = URL(string: endpoint) else { throw GHError.invalidURL }
    let (data, response) = try await URLSession.shared.data(from:url)
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
        throw GHError.invalidResponse
    }
    do{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(GitHubUser.self, from: data)
    }catch{
        throw GHError.invalidData
    }
}
