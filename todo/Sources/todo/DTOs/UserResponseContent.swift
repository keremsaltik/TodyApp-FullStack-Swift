//
//  UserResponseContent.swift
//  todo
//
//  Created by Kerem Saltık on 23.02.2026.
//

import Vapor
import Foundation

struct UserResponseContent: Content{
    let id: UUID
    let mail: String
    let fullName: String
}


// MARK: - Helpers

extension UserResponseContent{
    init?(user: User?) throws{
        guard let user else { return nil}
        id = try user.requireID()
        mail = user.mail
        fullName = user.fullName
    }
}
