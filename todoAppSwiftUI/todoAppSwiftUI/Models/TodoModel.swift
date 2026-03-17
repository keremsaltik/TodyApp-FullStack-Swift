//
//  TodoModel.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 2.03.2026.
//

import Foundation

struct TodoModel: Codable, Identifiable, Hashable{
    let id: UUID
    let title: String
    let description: String
    let startDate: Date
    let endDate: Date?
    let isCompleted: Bool
    let user: UserModel
}

extension TodoModel {
    static let mock = TodoModel(
        id: UUID(),
        title: "Vapor Backend'i Bitir",
        description: "CRUD işlemlerini ve JWT güvenliğini tamamla, sonra iOS tarafına bağla.",
        startDate: Date(),
        endDate: Date(),
        isCompleted: false,
        user: UserModel(id: UUID(), mail: "keremsaltikbusiness@gmail.com", fullName: "Kerem Saltık")
    )
}
