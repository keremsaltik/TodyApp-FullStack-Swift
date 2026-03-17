//
//  TodoService.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 9.03.2026.
//

import Foundation

class TodoService{
    
    static let shared = TodoService()
    
    private init(){}
    
    private let manager = NetworkManager.shared
    
    private let sessionManager = SessionManager.shared

    // MARK: - READ
    func getTodos(date: Date? = nil) async throws -> [TodoModel]{
        guard let token = sessionManager.getToken() else { throw APIError.unauthorized }
        let response: Page<TodoModel> = try await manager.request(TodoEndpoint.getAll(token: token, date: date))
        return response.items
    }
    
    
    // MARK: - CREATE
    func addTodo(_ todo: TodoRequest)  async throws -> TodoModel{
        
        guard let token = sessionManager.getToken() else { throw APIError.unauthorized }
        
        return try await manager.request(TodoEndpoint.create(todo, token: token))
    }
    
    // MARK: - UPDATE
    func updateTodo(id: UUID, with todo: TodoRequest) async throws -> TodoModel{
        
        guard let token = sessionManager.getToken() else { throw APIError.unauthorized }
        
        return try await manager.request(TodoEndpoint.update(id: id, todo: todo, token: token))
    }
    
    // MARK: - DELETE
    func deleteTodo(id: UUID) async throws{
        guard let token = sessionManager.getToken() else { throw APIError.unauthorized }
                
            
                try await manager.requestNoContent(TodoEndpoint.delete(id: id, token: token))
    }
}
