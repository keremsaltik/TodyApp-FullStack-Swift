//
//  todoAppSwiftUIApp.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 2.03.2026.
//

import SwiftUI

@main
struct todoAppSwiftUIApp: App {
    
    @StateObject var sessionManager = SessionManager.shared
    
    @StateObject var navManager = NavigationManager.shared
    
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    
    var body: some Scene {
        
        WindowGroup {
            ZStack {
               
                Color.white.ignoresSafeArea()
                
                if !hasSeenOnboarding {
                    WelcomeView()
                    
                } else if sessionManager.isLoadingAuthentication {
                    VStack(spacing: 20) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(Color(red: 36/255, green: 161/255, blue: 156/255))
                        ProgressView().tint(.white)
                    }
                } else {
                    NavigationStack(path: $navManager.path) {
                        Group {
                            if sessionManager.isLoggedIn {
                                CustomTabView()
                            } else {
                                LoginView()
                            }
                        }
                        .navigationDestination(for: Route.self) { route in
                            switch route {
                            case .register:
                                RegisterView()
                            case .update(let task):
                                UpdateTodoView(todo: task)
                            case .home:
                                CustomTabView()
                            case .profile:
                                SettingsView()
                            }
                        }
                    }
                }
            }
            .environmentObject(sessionManager)
            .environmentObject(navManager)
        }
    }
}

