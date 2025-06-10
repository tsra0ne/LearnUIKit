//
//  NetworkManager.swift
//  LearnUIKit
//
//  Created by Sravan Goud on 10/06/25.
//

import Foundation

class NetworkManager {
    private let baseURL: String = "http://localhost:3000/posts"
    
    static let shared = NetworkManager()
    
    func getPosts() async throws -> [Post]? {
        guard let url = URL(string: baseURL) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        let result = try decoder.decode([Post].self, from: data)
        
        return result
    }
    
    func addPost(_ post: Post) async throws -> Bool {
        guard let url = URL(string: baseURL) else { return false }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(post)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
            return true
        }
        return false
    }
    
    func deletePost(_ post: Post) async throws -> Bool {
        guard let url = URL(string: baseURL + "/\(post.id)") else { return false }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (_, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
            return true
        }
        return false
    }
    
    func updatePost(_ post: Post) async throws -> Post? {
        guard let url = URL(string: baseURL + "/\(post.id)") else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        
        let postBody = Post(id: post.id, title: post.title, views: 0)
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(postBody)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
            return postBody
        }
        return nil
    }
}
