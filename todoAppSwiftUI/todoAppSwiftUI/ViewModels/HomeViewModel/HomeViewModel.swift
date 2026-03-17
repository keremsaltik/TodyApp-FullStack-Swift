//
//  HomeViewModel.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 12.03.2026.
//

import Foundation
internal import Combine

@MainActor
class HomeViewModel: ObservableObject{
    
    @Published var todos: [TodoModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var selectedDate: Date = Date() {
        didSet {
            Task { await fetchTodos() }
        }
    }
    
    private let todoService = TodoService.shared
    
    func fetchTodos() async{
        isLoading = true
        errorMessage = nil
        
        
        do{
            let fetchedTodos = try await todoService.getTodos(date: selectedDate)
            self.todos = fetchedTodos
            isLoading = false
        }catch{
            isLoading = false
            self.errorMessage = error.localizedDescription
            
        }
    }
    
    func deleteTodo(at indexSet: IndexSet) async{
        let idsToDelete = indexSet.map { todos[$0].id }
                
                for id in idsToDelete {
                    do {
                        try await todoService.deleteTodo(id: id)
                        self.todos.removeAll(where: { $0.id == id })
                    } catch {
                        self.errorMessage = error.localizedDescription
                    }
                }
    }
    
    func addNewTodo(title: String, description: String) async{
        let newTodo = TodoRequest(title: title, description: description, startDate: Date(), endDate: nil, isCompleted: false)
        
        do{
            let createTodo = try await todoService.addTodo(newTodo)
            
            self.todos.append(createTodo)
        }catch{
            self.errorMessage = error.localizedDescription
        }
    }
    
    
    func toggleCompletion(todo: TodoModel) async{
        
        guard let index = todos.firstIndex(where: { $0.id == todo.id }) else { return }
            
            self.todos[index] = TodoModel(
                id: todo.id,
                title: todo.title,
                description: todo.description,
                startDate: todo.startDate,
                endDate: todo.endDate,
                isCompleted: !todo.isCompleted, // Hemen tersine çevirdik
                user: todo.user
            )
        
        
        let request = TodoRequest(
                    title: todo.title,
                    description: todo.description,
                    startDate: todo.startDate,
                    endDate: todo.endDate,
                    isCompleted: !todo.isCompleted // Durumu tersine çeviriyoruz
                )
                
                do {
                    let updatedTodo = try await todoService.updateTodo(id: todo.id, with: request)
                    if let index = todos.firstIndex(where: { $0.id == todo.id }) {
                        self.todos[index] = updatedTodo
                    }
                } catch {
                    self.errorMessage = error.localizedDescription
                }
            }
}
