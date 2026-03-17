//
//  UserEndpoint.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 11.03.2026.
//

import Foundation

enum UserEndpoint: APIEndpoint {
    case login(LoginRequest), register(RegisterRequest), getMe
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var path: String {
        switch self { case .login: return "/users/login"; case .register: return "/users";  case .getMe: return "/users/me"}
    }
    var method: HTTPMethod { switch self {
    case .getMe: return .get
    default: return .post
    }
    }
    var body: Data? {
        switch self {
        case .login(let req): return try? JSONEncoder().encode(req)
        case .register(let req): return try? JSONEncoder().encode(req)
        case .getMe: return nil
        }
    }
    var headers: [String : String]? {
        
        var header = ["Content-Type": "application/json"]
        
        if case .getMe = self {
        if let token = SessionManager.shared.getToken() {
            header["Authorization"] = "Bearer \(token)"
        }
    }
        return header
    }

   
}
