//
//  Todo.swift
//  todo
//
//  Created by Kerem Saltık on 19.02.2026.
//

import Fluent
import Vapor


final class Todo: Model, @unchecked Sendable{
    static let schema = "todos"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @OptionalField(key: "description")
    var description: String?
    
    @Field(key: "start_date")
    var startDate: Date
    
    @OptionalField(key: "end_date")
    var endDate: Date?
    
    @Boolean(key: "is_completed")
    var isCompleted: Bool
    
    @Parent(key: "user_id")
    var user: User
    
    init() {}
    
    init(id: UUID? = nil, title: String, description: String? = nil, startDate: Date, endDate: Date? = nil, isCompleted: Bool, userID: User.IDValue) {
        self.id = id
        self.title = title
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
        self.isCompleted = isCompleted
        self.$user.id = userID
    }
}
