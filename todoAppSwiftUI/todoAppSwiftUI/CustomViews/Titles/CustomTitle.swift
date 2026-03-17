//
//  CustomTitle.swift
//  todoApp
//
//  Created by Kerem Saltık on 18.09.2025.
//

import SwiftUI

struct CustomTitle: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 24, weight: .semibold))
            .foregroundColor(.primary) 
    }
}

