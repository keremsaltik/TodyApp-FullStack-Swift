//
//  UpdateTodoViewModel.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 7.03.2026.
//

import Foundation
internal import Combine
import SwiftUI

@MainActor
class UpdateTodoViewModel: ObservableObject{
    
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var startDate: Date = Date()
    @Published var endDate: Date? = nil
    @Published var isCompleted: Bool = false
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isUpdateSuccessful = false
    
    private let todoService = TodoService.shared
    
    private let todoID: UUID
    
    init(todo: TodoModel) {
        self.todoID = todo.id
        self.title = todo.title
        self.description = todo.description
        self.startDate = todo.startDate
        self.endDate = todo.endDate ?? Date()
        self.isCompleted = todo.isCompleted
    }
    
    var endDateBinding: Binding<Date> {
        Binding(
            get: { self.endDate ?? Date() },
            set: { self.endDate = $0 }
        )
    }
    
    func update() async{
        
        isLoading = true
        errorMessage = nil
        
        let request = TodoRequest(
            title: title,
            description: description,
            startDate: startDate,
            endDate: endDate,
            isCompleted: isCompleted
        )
        
        do{
            _ = try await todoService.updateTodo(id: todoID, with: request)
            
            self.isLoading = false
            self.isUpdateSuccessful = true
        }catch{
            self.isLoading = false
            self.errorMessage = error.localizedDescription
        }
    }
}
