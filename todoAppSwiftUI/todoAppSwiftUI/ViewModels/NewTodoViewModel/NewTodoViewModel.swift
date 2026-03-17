//
//  NewTodoViewModel.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 7.03.2026.
//

import Foundation
internal import Combine

@MainActor
class NewTodoViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isSaveSuccessful = false
    
    private let todoService = TodoService.shared
    
    func createTodo(title: String, description: String, startDate: Date, endDate: Date?) async {
        guard !title.isEmpty else {
            self.errorMessage = "Title cannot be empty"
            return
        }
        
        self.isLoading = true
        self.errorMessage = nil
        
        let request = TodoRequest(
            title: title,
            description: description,
            startDate: startDate,
            endDate: endDate,
            isCompleted: false
        )
        
        do {
            _ = try await todoService.addTodo(request)
            
            self.isSaveSuccessful = true
            self.isLoading = false
        } catch {
            self.isLoading = false
            self.errorMessage = error.localizedDescription
        }
    }
}
