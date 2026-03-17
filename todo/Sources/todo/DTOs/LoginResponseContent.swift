//
//  LoginResponseContent.swift
//  todo
//
//  Created by Kerem Saltık on 11.03.2026.
//

import Vapor

struct LoginResponseContent: Content {
    let token: String
    let user: UserResponseContent
}
