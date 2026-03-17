//
//  RegisterViewModel.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 12.03.2026.
//

import Foundation
internal import Combine


@MainActor
class RegisterViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isSuccessfullyRegistered = false
    
    private let userService = UserService.shared
    
    
    func register(fullName: String, mail: String, password: String){
        guard !fullName.isEmpty, !mail.isEmpty, !password.isEmpty else{
            self.errorMessage = "Please fill all fields."
            return
        }
        
        guard password.count >= 6 else {
                   self.errorMessage = "The password must be minimum 6 characters."
                   return
               }
        
        isLoading = true
        errorMessage = nil
     
        
        
        Task{
            do{
                try await userService.register(mail: mail, pass: password, fullName: fullName)
                
                isLoading = false
                isSuccessfullyRegistered = true
            }catch{
                isLoading = false
                self.errorMessage = error.localizedDescription
                print("Login hatası: \(error)")
            }
        }
        
    }
    
}
