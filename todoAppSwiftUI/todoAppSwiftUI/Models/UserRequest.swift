//
//  UserRequest.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 11.03.2026.
//

import Foundation


struct RegisterRequest: Encodable {
    let mail: String
    let password: String
    let fullName: String
}


struct LoginRequest: Encodable {
    let mail: String
    let password: String
}
