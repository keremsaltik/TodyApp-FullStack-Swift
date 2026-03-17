//
//  SessionManager.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 9.03.2026.
//

import Foundation
import KeychainAccess
internal import Combine

@MainActor
class SessionManager: ObservableObject{
    
    static let shared = SessionManager()
    
    @Published var accountDetails: UserModel?
    @Published var isLoggedIn = false
    @Published var isLoadingAuthentication = true
    private let keychain = Keychain(service: "com.keremsaltik.todoAppSwiftUI")
    
    private(set) var currentUser: UserModel?
    
    private init(){
        Task {
            await checkAuthentication()
        }
    }
    
    
    func checkAuthentication() async {
        guard let _ = getToken() else {
            self.isLoggedIn = false
            self.isLoadingAuthentication = false // Kontrol bitti
            return
        }
        
        do {
            let user = try await UserService.shared.getMe()
            self.accountDetails = user
            self.isLoggedIn = true
        } catch {
            logout()
        }
        self.isLoadingAuthentication = false
    }
    
    func saveToken(_ token: String, user: UserModel) async{
        try? keychain.set(token, key: K.Keychain.tokenKey)
        self.accountDetails = user
        self.isLoggedIn = true
    }
    
    func logout() {
        try? keychain.remove(K.Keychain.tokenKey)
        self.accountDetails = nil
        self.isLoggedIn = false
    }
    
    func getToken() -> String? {
        return try? keychain.get(K.Keychain.tokenKey)
    }
    
}
