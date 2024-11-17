//
//  FlashcardView.swift
//  NuLingo
//
//  Created by Batyr Tolkynbayev on 17.11.2024.
//

import SwiftUI

struct FlashcardView: View {
    @Environment(\.colorScheme) var colorScheme

    var categoryTitle: String
    @State private var currentIndex: Int = 1
    private let totalCards = 30

    var body: some View {
        VStack {
            HStack {
                Text(categoryTitle)
                    .font(.manropeBold(size: 24))
                
                Spacer()
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Cards
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<2) { _ in
                        cardView(
                            text: """
                            “Менің отбасым әлемдегі ең күшті отбасы және мен өз ата-анаммен мақтанамын”
                            """,
                            translation: """
                            "Моя семья-самая сильная семья в мире, и я горжусь своими родителями"
                            """
                        )
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            // Bottom Navigation
            HStack {
                Button(action: {
                    if currentIndex < totalCards {
                        currentIndex += 1
                    }
                }) {
                    Text("Next")
                        .font(.manropeSemiBold(size: 18))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                Text("\(currentIndex)/\(totalCards)")
                    .font(.manropeRegular(size: 16))
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
    
    private func cardView(text: String, translation: String) -> some View {
        VStack(spacing: 16) {
            Text(text)
                .font(.manropeSemiBold(size: 20))
                .multilineTextAlignment(.center)
            
            Button(action: {
                print("Play sound tapped")
            }) {
                Image(systemName: "speaker.wave.2.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.blue)
                    .padding(10)
                    .background(Color(uiColor: .systemGray5))
                    .cornerRadius(10)
            }
            
            Text(translation)
                .font(.manropeSemiBold(size: 20))
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(uiColor: .systemGray5))
        .cornerRadius(20)
    }
}
