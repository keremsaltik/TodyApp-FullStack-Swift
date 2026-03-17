//
//  TodoEndpoint.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 11.03.2026.
//

import Foundation

enum TodoEndpoint: APIEndpoint {
    case getAll(token: String, date: Date?)
    case getOne(id: UUID, token: String)
    case create(TodoRequest, token: String)
    case update(id: UUID, todo: TodoRequest, token: String)
    case delete(id: UUID, token: String)
    
    
    var queryItems: [URLQueryItem]? {
           switch self {
           case .getAll(_, let date):
               guard let date = date else { return nil }
               let formatter = ISO8601DateFormatter()
               formatter.formatOptions = [.withFullDate]
               let dateString = formatter.string(from: date)
               return [URLQueryItem(name: "date", value: dateString)]
           default:
               return nil
           }
       }
    
    var path: String {
        switch self {
        case .getAll, .create:
            return "/todos"
        case .getOne(let id, _), .update(let id, _, _), .delete(let id, _):
            return "/todos/\(id.uuidString)" // Vapor'daki :id kısmını doldurur
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAll, .getOne: return .get
        case .create: return .post
        case .update: return .put
        case .delete: return .delete
        }
    }
    
    var body: Data? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        switch self {
        case .create(let todo, _), .update(_, let todo, _):
            return try? encoder.encode(todo)
        default:
            return nil
        }
    }
    
    var headers: [String : String]? {
        var header = ["Content-Type": "application/json"]
        switch self {
        case .getAll(let token, _), .getOne(_, let token), .create(_, let token), .update(_, _, let token), .delete(_, let token):
            header["Authorization"] = "Bearer \(token)"
        }
        return header
    }
}
