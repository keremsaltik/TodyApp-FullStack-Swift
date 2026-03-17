//
//  TodoRequest.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 10.03.2026.
//

import Foundation

struct TodoRequest: Encodable {
    let title: String
    let description: String
    let startDate: Date
    let endDate: Date?
    let isCompleted: Bool
}
