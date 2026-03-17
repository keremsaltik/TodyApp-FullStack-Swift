//
//  APIEndpoint.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 11.03.2026.
//

import Foundation

enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}


protocol APIEndpoint{
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
}
