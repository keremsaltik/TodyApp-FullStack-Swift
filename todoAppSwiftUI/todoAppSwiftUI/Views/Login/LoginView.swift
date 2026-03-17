//
//  LoginView.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 2.03.2026.
//

import SwiftUI


struct LoginView: View {
    @State private var mail: String = ""
    @State private var password = ""
    
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        VStack() {
            CustomTitle(text: "Welcome Back")
            
            CustomSubTitle(text: "Your work faster and structured with Todapp")
                .padding(.vertical, 8)
            
            CustomFormLabel(text: "Email Address")
                .padding(.top, 24)
            
            CustomTextField(placeholder: "name@example.com", text: $mail)
            
            CustomFormLabel(text: "Password")
                .padding(.top, 24)
            
            CustomTextField(placeholder: "Enter your password,", text: $password, isSecure: true)
            
            if let error = loginViewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.top, 8)
            }
            
            Spacer()
            
            
            if loginViewModel.isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            } else {
                Button("Next") {
                    loginViewModel.login(mail: mail, password: password)
                }
                .buttonStyle(CustomButtonStyle())
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 20)
        
        NavigationLink(value: Route.register)
        {
            Text("Don't have an account? **Register**")
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding(.top, 10)
    }
}


#Preview {
    LoginView()
}
