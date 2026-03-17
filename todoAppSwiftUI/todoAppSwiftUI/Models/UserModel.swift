//
//  UserModel.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 2.03.2026.
//

import Foundation

struct UserModel: Codable, Identifiable, Hashable{
    let id: UUID
    let mail: String
    let fullName: String
}
