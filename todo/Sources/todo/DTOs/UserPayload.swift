//
//  UserPayload.swift
//  todo
//
//  Created by Kerem Saltık on 2.03.2026.
//

import Vapor
import JWT



struct UserPayload: JWTPayload, Authenticatable{
    var userID: UUID
    var mail: String
    
    
    var exp:ExpirationClaim
    
    func verify(using algorithm: some JWTAlgorithm) async throws {
        try self.exp.verifyNotExpired()
    }
}
