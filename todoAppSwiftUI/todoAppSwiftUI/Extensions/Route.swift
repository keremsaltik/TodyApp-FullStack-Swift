//
//  Route.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 14.03.2026.
//

import Foundation

enum Route: Hashable {
    case register
    case home
    case update(TodoModel)
    case profile
}
