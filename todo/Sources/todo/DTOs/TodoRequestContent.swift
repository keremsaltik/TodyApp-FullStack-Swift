//
//  TodoRequestContent.swift
//  todo
//
//  Created by Kerem Saltık on 19.02.2026.
//

import Vapor


struct TodoRequestContent: Content {
    let title: String?
    let description: String
    let startDate: Date
    let endDate: Date?
    var isCompleted: Bool
}

// MARK: - Helper for Fluent Model

extension Todo{
    convenience init(
        requestContent: TodoRequestContent,
        title: String
    ){
        self.init()
        self.title = title
        description = requestContent.description
        startDate = requestContent.startDate
        endDate = requestContent.endDate
        isCompleted = requestContent.isCompleted
    }
    
}


