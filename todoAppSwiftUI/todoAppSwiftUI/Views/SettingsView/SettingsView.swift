//
//  SettingsView.swift
//  todoAppSwiftUI
//
//  Created by Kerem Saltık on 14.03.2026.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State private var showingLogoutAlert = false

    
    
    let secondaryTextColor = Color(red: 108/255, green: 117/255, blue: 125/255)
    
    var nameForURL: String {
        (sessionManager.accountDetails?.fullName ?? "User").replacingOccurrences(of: " ", with: "+")
    }

    var avatarURL: URL? {
        URL(string: "https://ui-avatars.com/api/?name=\(nameForURL)&background=24A19C&color=fff&size=128")
    }
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                VStack(spacing: 12) {
                    ZStack(alignment: .bottomTrailing) {
                        AsyncImage(url: avatarURL) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            case .failure(_):
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .foregroundColor(.gray)
                            case .empty:
                                ProgressView()
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))

                        Image(systemName: "pencil.circle.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, Color(red: 36/255, green: 161/255, blue: 156/255))
                            .font(.system(size: 30))
                            .background(Circle().fill(.white))
                            .offset(x: 5, y: 5)
                    }
                    
                    VStack(spacing: 4) {

                        Text(sessionManager.accountDetails?.fullName ?? "Name Surname")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.primary)
                        

                        Text("@\(sessionManager.accountDetails?.mail.split(separator: "@").first ?? "user")")
                            .font(.system(size: 16))
                            .foregroundColor(secondaryTextColor)
                    }
                }
                .padding(.top, 20)


                VStack(spacing: 0) {
                    SettingsRow(icon: "person", title: "Account")
                    SettingsRow(icon: "pencil.and.outline", title: "Theme")
                    SettingsRow(icon: "app.badge", title: "App Icon")
                    SettingsRow(icon: " flowchart", title: "Productivity")
                    

                    HStack(spacing: 16) {
                        Image(systemName: "sun.max")
                            .font(.system(size: 20))
                        Text("Change Mode")
                            .font(.system(size: 16))
                        Spacer()
                        Text("System")
                               .font(.subheadline)
                               .foregroundColor(.secondary)
                    }
                    .foregroundColor(secondaryTextColor)
                    .padding()
                    
                    Divider().background(Color.gray.opacity(0.3)).padding(.vertical, 10)
                    
                    SettingsRow(icon: "lock", title: "Privacy Policy")
                    SettingsRow(icon: "questionmark.circle", title: "Help Center")
                    

                    Button(action: { showingLogoutAlert = true }) {
                        SettingsRow(icon: "rectangle.portrait.and.arrow.right", title: "Log Out", showChevron: false)
                            .foregroundColor(.red)
                    }
                }
                .cornerRadius(16)
                .padding(.horizontal, 16)
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        
        .alert("Sign Out", isPresented: $showingLogoutAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Sign Out", role: .destructive) {
                sessionManager.logout()
            }
        } message: {
            Text("Are you sure you want to sign out?")
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    var showChevron: Bool = true
    let secondaryTextColor = Color(red: 108/255, green: 117/255, blue: 125/255)
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .frame(width: 24)
            
            Text(title)
                .font(.system(size: 16))
            
            Spacer()
            
            if showChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .opacity(0.5)
            }
        }
        .foregroundColor(secondaryTextColor)
        .padding()
        .contentShape(Rectangle()) // Tüm satırı tıklanabilir yapar
    }
}
