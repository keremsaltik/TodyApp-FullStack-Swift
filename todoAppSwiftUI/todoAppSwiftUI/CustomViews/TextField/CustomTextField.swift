//
//  CustomTextField.swift
//  todoApp
//
//  Created by Kerem Saltık on 17.09.2025.
//

import SwiftUI
struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        Group{
            if isSecure{
                SecureField(placeholder, text: $text)
            }else{
                TextField(placeholder, text: $text)
            }
        }
        .padding(.horizontal, 12)
        .frame(height: 45)
        .foregroundStyle(Color(.lightGray))
        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color(.systemGray4), lineWidth: 1))
        .background(Color(.systemBackground))
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
    }
}
