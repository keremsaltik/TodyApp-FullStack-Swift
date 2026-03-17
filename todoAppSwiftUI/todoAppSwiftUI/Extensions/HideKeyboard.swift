//
//  HideKeyboard.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 17.03.2026.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
