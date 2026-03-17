//
//  LoginResponse.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 11.03.2026.
//

import Foundation


struct LoginResponse: Decodable {
    let token: String
    let user: UserModel
}
