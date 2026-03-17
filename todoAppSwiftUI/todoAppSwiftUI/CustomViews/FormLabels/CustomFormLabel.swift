//
//  FormLabels.swift
//  todoApp
//
//  Created by Kerem Saltık on 19.09.2025.
//

import SwiftUI

struct CustomFormLabel: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
