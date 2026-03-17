//
//  UserService.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 9.03.2026.
//

import Foundation

class UserService {
    static let shared = UserService()
    private init() {}
    
    private let manager = NetworkManager.shared
    private let sessionManager = SessionManager.shared

    // MARK: - REGISTER
    func register(mail: String, pass: String, fullName: String) async throws {
        let requestBody = RegisterRequest(mail: mail, password: pass, fullName: fullName)
        
        try await manager.requestNoContent(UserEndpoint.register(requestBody))
    }

    // MARK: - LOGIN
    func login(mail: String, pass: String) async throws {
        let requestBody = LoginRequest(mail: mail, password: pass)
        
        let response: LoginResponse = try await manager.request(UserEndpoint.login(requestBody))
        
        await sessionManager.saveToken(response.token, user: response.user)
    }
    
    // MARK: - USER
    func getMe() async throws -> UserModel {
        let user: UserModel = try await manager.request(UserEndpoint.getMe)
        return user
    }
}
