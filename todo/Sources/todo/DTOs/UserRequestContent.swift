//
//  UserRequestContent.swift
//  todo
//
//  Created by Kerem Saltık on 23.02.2026.
//

import Vapor

struct RegisterRequestContent: Content {
    let mail: String?
    let password: String?
    let fullName: String?
}

struct LoginRequestContent: Content {
    let mail: String?
    let password: String?
}

// MARK: - Helper for User Entity
extension User {
    convenience init(mail: String, passwordHash: String, fullName: String) {
        self.init()
        self.mail = mail
        self.password = passwordHash
        self.fullName = fullName
    }
}
