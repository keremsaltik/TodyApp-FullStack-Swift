//
//  UpdateTodoView.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 7.03.2026.
//

import SwiftUI


struct UpdateTodoView: View {
    
    
    @EnvironmentObject var navManager: NavigationManager
    @StateObject var viewModel: UpdateTodoViewModel
    
    // MARK: - Initializer
    init(todo: TodoModel) {
        _viewModel = StateObject(wrappedValue: UpdateTodoViewModel(todo: todo))
    }
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack(alignment: .leading, spacing: 10) {
                    CustomTextField(placeholder: "eg: Meeting", text: $viewModel.title)
                    CustomTextField(placeholder: "Description", text: $viewModel.description)
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    CustomTitle(text: "Date & Time")
                    
                    VStack(alignment: .leading, spacing: 8) {
                        CustomSubTitle(text: "Start Date")
                        CustomDatePicker(selection: $viewModel.startDate, label: "Start")
                            .labelsHidden()
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        CustomSubTitle(text: "End Date")
                        CustomDatePicker(selection: viewModel.endDateBinding, label: "End")
                            .labelsHidden()
                        
                    }
                }
                
                Spacer(minLength: 40)
                
                Button("Update & Save") {
                    Task{
                        await viewModel.update()
                        if viewModel.isUpdateSuccessful {
                            navManager.pop()
                        }
                    }
                }
                .buttonStyle(CustomButtonStyle())
            }
            .padding(30)
            .disabled(viewModel.isLoading)
        }
        .navigationTitle("Edit Task")
    }
    
}

#Preview {
    NavigationStack {
        UpdateTodoView(todo: .mock)
    }
}
