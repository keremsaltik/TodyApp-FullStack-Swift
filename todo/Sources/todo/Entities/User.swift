//
//  User.swift
//  todo
//
//  Created by Kerem Saltık on 19.02.2026.
//

import Fluent
import Foundation
import Vapor

final class User: Model, Content, @unchecked Sendable{
 static let schema: String = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "mail")
    var mail: String
    
    @Field(key: "password")
    var password: String
    
    @Field(key: "fullname")
    var fullName: String
    
    @Children(for: \.$user)
    var todo: [Todo]
    
    init(){}
    
    init(id: UUID? = nil, mail: String, password: String) {
        self.id = id
        self.mail = mail
        self.password = password
    }
}
