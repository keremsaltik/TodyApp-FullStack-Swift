//
//  CustomButton.swift
//  todoApp
//
//  Created by Kerem Saltık on 22.09.2025.
//

import SwiftUI



struct CustomButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color(red: 36/255, green: 161/255, blue: 156/255))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .font(.headline)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
    
}
