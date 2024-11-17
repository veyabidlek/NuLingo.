//
//  Textfield.swift
//  NuLingo
//
//  Created by Batyr Tolkynbayev on 16.11.2024.
//

import SwiftUI

struct Textfield: View {
    @Binding var text: String
    
    var placeholder: String
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .font(.system(size: 16))
                .padding(10)
        }
        .background(Color(UIColor.systemGray5))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

