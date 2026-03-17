//
//  UserController.swift
//  todo
//
//  Created by Kerem Saltık on 1.03.2026.
//

import Fluent
import Foundation
import Vapor

struct UserController: RouteCollection, Sendable {
    func boot(routes: any RoutesBuilder) throws {
        let users = routes.grouped("users")
        
        // CREATE
        users.post { request in
            try await createUser(request: request)
        }
        
        // READ
        users.get(":id") { request in
            try await getUser(request: request)
        }
        
        // DELETE
        users.delete(":id") { request in
            try await deleteUser(request: request)
        }
        
        // LOGIN
        users.post("login") { request in
            try await loginUser(request: request)
        }
        
        let protected = users.grouped(UserPayload.authenticator(), UserPayload.guardMiddleware())
        
        protected.get("me") { request in
            try await getMe(request: request)
        }
    
    }
    
    
    // MARK: - Create
    private func createUser(request: Request) async throws -> UserResponseContent{
        
        let requestContent = try request.content.decode(RegisterRequestContent.self)
        
        guard let fullName = requestContent.fullName, let mail = requestContent.mail, let plainPassword = requestContent.password else{
            throw Abort(.badRequest, reason: "Full name, mail and password are required")
        }
        
        let hashedPassword = try request.password.hash(plainPassword)
        
        let user = User(
            mail: mail,
            passwordHash: hashedPassword,
            fullName: fullName
        )
        
        let existingUser = try await User.query(on: request.db)
            .filter(\.$mail == mail)
            .first()

        if existingUser != nil {
            throw Abort(.conflict, reason: "This email is already registered")
        }
        
        try await user.create(on: request.db)
        
        guard let response = try UserResponseContent(user: user) else {
                throw Abort(.internalServerError)
            }
            return response
    }
    
    //MARK: - Read
    private func getUser(request: Request) async throws -> UserResponseContent{
        let user: User = try await findByID(request: request)
        
        return try UserResponseContent(user: user)!
    }
    
    private func getMe(request: Request) async throws -> UserResponseContent {

        let userPayload = try request.auth.require(UserPayload.self)
        

        guard let user = try await User.find(userPayload.userID, on: request.db) else {
            throw Abort(.notFound, reason: "User not found.")
        }
        

        return try UserResponseContent(user: user)!
    }
    
    //MARK: - Delete
    private func deleteUser(request: Request) async throws -> HTTPStatus{
        guard let mail: String = try request.content.get(at: "mail") else{
            throw Abort(.badRequest, reason: "User cannot found")
        }
        
        try await User.query(on: request.db)
            .filter(\.$mail =~ mail )
            .delete()
        
        return .noContent
    }
    
    //MARK: - Login
    private func loginUser(request: Request) async throws -> LoginResponseContent{
        let loginDTO = try request.content.decode(LoginRequestContent.self)
        
        guard let mail = loginDTO.mail, let password = loginDTO.password else{
            throw Abort(.badRequest, reason: "Mail ve password required.")
        }
        
        guard let user = try await User.query(on: request.db)
            .filter(\.$mail == mail)
            .first() else {
            throw Abort(.unauthorized, reason: "Wrong e-mail or password.")
        }
        
        let isPasswordCorrect = try request.password.verify(password, created: user.password)
        
        if !isPasswordCorrect {
                throw Abort(.unauthorized, reason: "Wrong password.")
            }
        
        let payload = try UserPayload(userID: user.requireID(), mail: user.mail, exp: .init(value: Date().addingTimeInterval(24 * 60 * 60))) // 24 saat geçerli
        
        let token = try await request.jwt.sign(payload)
        let userResponse = try UserResponseContent(user: user)!
        
        return LoginResponseContent(token: token, user: userResponse)
    }
}
