//
//  NetworkManager.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 11.03.2026.
//

import Foundation

class NetworkManager{
    
    static let shared = NetworkManager()
    private let session = URLSession.shared
    
    private init(){}
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T{
        guard var urlComponents = URLComponents(string: K.API.baseURL + endpoint.path) else {
               throw URLError(.badURL)
        }
        
        urlComponents.queryItems = endpoint.queryItems
        
        guard let url = urlComponents.url else { throw URLError(.badURL) }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        request.httpBody = endpoint.body
        
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else{
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
        
    }
    
    
    func requestNoContent(_ endpoint: APIEndpoint) async throws{
        guard let url = URL(string: K.API.baseURL + endpoint.path) else{
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        request.httpBody = endpoint.body
        
        
        let (_, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else{
            throw URLError(.badServerResponse)
        }
    }
    
}
