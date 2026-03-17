//
//  LoginViewModel.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 12.03.2026.
//

import Foundation
internal import Combine


@MainActor
class LoginViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let userService = UserService.shared
    

    
    func login(mail: String, password: String){
        guard !mail.isEmpty, !password.isEmpty else{
            self.errorMessage = "Please fill all fields."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task{
            do{
                try await userService.login(mail: mail, pass: password)
                
                isLoading = false
            }catch{
                isLoading = false
                self.errorMessage = error.localizedDescription
                print("Login hatası: \(error)")
            }
        }
    }
}
