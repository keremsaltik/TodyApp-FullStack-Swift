//
//  SubTitles.swift
//  todoApp
//
//  Created by Kerem Saltık on 19.09.2025.
//

import SwiftUI

struct CustomSubTitle: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(.gray)
            .multilineTextAlignment(.leading)
    }
}
