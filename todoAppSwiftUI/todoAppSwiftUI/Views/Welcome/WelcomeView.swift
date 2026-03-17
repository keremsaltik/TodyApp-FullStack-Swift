//
//  WelcomeView.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 16.03.2026.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    
    var body: some View {
        ZStack {
            Color(red: 36/255, green: 161/255, blue: 156/255)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                
                Image(.logoOnboarding)
                    .font(.system(size: 80))
                
                Text("Todyapp")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                
                Text("The best to do list application for you")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        hasSeenOnboarding = true
                    }
                }) {
                    Text("Get Started")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color(red: 36/255, green: 161/255, blue: 156/255))
                        .cornerRadius(12)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    WelcomeView(hasSeenOnboarding: true)
}
