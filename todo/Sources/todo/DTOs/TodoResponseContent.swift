//
//  TodoResponseContent.swift
//  todo
//
//  Created by Kerem Saltık on 19.02.2026.
//

import Vapor

struct TodoResponseContent: Content {
    let id: UUID?
    let title: String?
    let description: String?
    let startDate: Date?
    let endDate: Date?
    var isCompleted: Bool?
    let user: UserResponseContent?
}

// MARK: - Helpers

extension TodoResponseContent{
    init(todo: Todo, user: User? = nil) throws{
        id = try todo.requireID()
        title = todo.title
        description = todo.description
        startDate = todo.startDate
        endDate = todo.endDate
        isCompleted = todo.isCompleted
        self.user = try UserResponseContent(user: user)
    }
}
