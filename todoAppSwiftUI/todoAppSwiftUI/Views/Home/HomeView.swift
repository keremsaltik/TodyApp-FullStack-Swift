//
//  HomeView.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 5.03.2026.
//

import SwiftUI

struct HomeView: View {
    
    
    
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var sessionManager: SessionManager
    
    let brandColor = Color(red: 36/255, green: 161/255, blue: 156/255)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            
            VStack(alignment: .leading, spacing: 8) {
                CustomTitle(text: "Today")
                CustomSubTitle(text: "Best platform for creating to-do lists")
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            
            DateScrollerView(selectedDate: $viewModel.selectedDate)
                   .padding(.vertical, 20)
            
            if viewModel.isLoading && viewModel.todos.isEmpty {
                Spacer()
                ProgressView("Loading tasks...")
                    .frame(maxWidth: .infinity)
                Spacer()
            } else {
                List {
                    
                    ForEach(viewModel.todos) { task in
                        NavigationLink(value: Route.update(task)) {
                            TaskRowView(task: task) {
                                Task {
                                    await viewModel.toggleCompletion(todo: task)
                                }
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(.plain)
                .refreshable {
                    await viewModel.fetchTodos()
                }
                
            }
        }
        
        .task {
            await viewModel.fetchTodos()
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(value: Route.profile) {
                    Image(systemName: "person.crop.circle")
                        .font(.title3)
                        .foregroundStyle(brandColor)
                }
            }
        }
        
    }
    
    
    
    
    private func deleteItems(at offsets: IndexSet) {
        Task {
            await viewModel.deleteTodo(at: offsets)
        }
        
    }
    
    
}


#Preview {
    CustomTabView()
}
