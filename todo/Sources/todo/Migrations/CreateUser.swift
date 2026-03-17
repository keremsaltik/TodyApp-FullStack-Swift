//
//  CreateUser.swift
//  todo
//
//  Created by Kerem Saltık on 28.02.2026.
//

import Fluent

struct CreateUser: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("users")
            .id()
            .field("mail", .string, .required)
            .field("password", .string, .required)
            .field("fullname", .string, .required)
            .unique(on: "mail")
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema("users").delete()
    }
}
