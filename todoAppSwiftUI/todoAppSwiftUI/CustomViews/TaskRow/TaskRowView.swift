//
//  TaskRowView.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 7.03.2026.
//


import SwiftUI

struct TaskRowView: View {
    let task: TodoModel
    var onStatusButtonTap: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            Button(action: onStatusButtonTap) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }
            .buttonStyle(.borderless)

            
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.system(size: 17, weight: .semibold))
                    .strikethrough(task.isCompleted)
                    .foregroundStyle(task.isCompleted ? .gray : .primary)
                
                Text(task.startDate, style: .date)
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
            }
            
            Spacer()
        }
        .padding()
        .background(task.isCompleted ? Color(white: 0.98) : Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
        .padding(.vertical, 6) 
    }
}
