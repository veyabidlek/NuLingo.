//
//  NextButton.swift
//  NuLingo
//
//  Created by Batyr Tolkynbayev on 16.11.2024.
//

import SwiftUI

struct NextButton: View {
    var title: String
    var action: (() -> ())?
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            Text(title)
                .font(.custom("Manrope-Bold", size: 16))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color(hex: "001A68"))
                .cornerRadius(20)
        }
        .padding(.horizontal, 30)
        .contentShape(Rectangle())
    }
}
