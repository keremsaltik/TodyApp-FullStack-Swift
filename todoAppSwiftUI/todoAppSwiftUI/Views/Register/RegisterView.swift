//
//  RegisterView.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 7.03.2026.
//

import SwiftUI

struct RegisterView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var fullName: String = ""
    @State var mail: String = ""
    @State var password: String = ""
    
    @StateObject var registerViewModel = RegisterViewModel()
    
    var body: some View {
        VStack() {
            
            
            VStack(spacing: 8) {
                CustomTitle(text: "Create Account")
                CustomSubTitle(text: "Create your account and feel the benefits")
            }
            .padding(.top, 40)
            
            
            VStack(alignment: .leading, spacing: 24) {
                
                VStack(alignment: .leading, spacing: 8) {
                    CustomFormLabel(text: "Full Name")
                    CustomTextField(placeholder: "Enter your full name", text: $fullName)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    CustomFormLabel(text: "Email Address")
                    CustomTextField(placeholder: "Enter your mail", text: $mail)
                }
                
                
                VStack(alignment: .leading, spacing: 8) {
                    CustomFormLabel(text: "Password")
                    CustomTextField(placeholder: "Enter your password", text: $password, isSecure: true)
                }
            }
            .padding(.top, 40)
            
            
            if let error = registerViewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.top, 10)
            }
            
            Spacer()
            
            if registerViewModel.isLoading {
                ProgressView()
                    .padding(.bottom, 30)
            } else {
                Button("Sign Up") {
                    registerViewModel.register(fullName: fullName, mail: mail, password: password)
                }
                .buttonStyle(CustomButtonStyle())
                .padding(.bottom, 20)
            }
        }
        .padding(.horizontal, 24)
        .alert("Success", isPresented: $registerViewModel.isSuccessfullyRegistered) {
            Button("Login Now") {
                dismiss()
            }
        } message: {
            Text("Your account has been created successfully!")
        }
    }
}
#Preview {
    RegisterView()
}
