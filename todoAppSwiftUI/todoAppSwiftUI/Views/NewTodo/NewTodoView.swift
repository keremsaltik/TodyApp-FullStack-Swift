//
//  NewTodoView.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 5.03.2026.
//

import SwiftUI

struct NewTodoView: View {
    // MARK: - Properties
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    
    @State private var showAlert = false
    
    @Binding var selectedTab: Int
    
    @StateObject var viewModel = NewTodoViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack(alignment: .leading, spacing: 8) {
                    CustomTitle(text: "New Todo")
                    CustomSubTitle(text: "Create a new task to stay organized")
                }
                .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 12) {
                    CustomTextField(placeholder: "eg: Meeting with client", text: $title)
                    CustomTextField(placeholder: "Description", text: $description)
                }
                
                
                VStack(alignment: .leading, spacing: 15) {
                    CustomTitle(text: "Date & Time")
                    
                    VStack(alignment: .leading, spacing: 8) {
                        CustomSubTitle(text: "Start Date")
                        CustomDatePicker(selection: $startDate, label: "Start")
                            .labelsHidden()
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        CustomSubTitle(text: "End Date")
                        CustomDatePicker(selection: $endDate, label: "End")
                            .labelsHidden()
                    }
                }
                
                Spacer(minLength: 50)
                
                
                Button("Save") {
                    Task {
                        await viewModel.createTodo(
                            title: title,
                            description: description,
                            startDate: startDate,
                            endDate: endDate
                        )
                        
                        if viewModel.isSaveSuccessful {
                            selectedTab = 0
                        }
                    }
                }
                .buttonStyle(CustomButtonStyle())
                
            }
            .padding(30)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .alert("Hata", isPresented: $showAlert) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text("Lütfen tüm alanları doldurun.")
        }
        .navigationTitle("New Todo")
    }
    
}




#Preview {
    CustomTabView()
}
