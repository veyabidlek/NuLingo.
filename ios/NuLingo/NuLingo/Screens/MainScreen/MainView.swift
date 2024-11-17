//
//  MainView.swift
//  NuLingo
//
//  Created by Batyr Tolkynbayev on 16.11.2024.
//

import SwiftUI
import Firebase

enum Language: String, CaseIterable, Identifiable {
    case kazakh
    case turkish
    case russian
    
    var id: String { self.rawValue }
}

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var router: MainRouter
    
    let cardNames: [Language: String] = [
        .kazakh: "Kazakh 🇰🇿",
        .turkish: "Turkish 🇹🇷",
        .russian: "Russian 🇷🇺"
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            Text("What language are we going to learn today?")
                .foregroundStyle(.gray)
                .font(.manropeBold(size: 24))
            
            ScrollView {
                ForEach(Language.allCases) {
                    languageCard(for: $0)
                }
            }
        }
        .padding(.horizontal, 10)
        .onAppear {
            router.customizeBar()
        }
    }
    
    private func languageCard(for language: Language) -> some View {
        Button {
            router.openLanguageView(language: language)
        } label: {
            ZStack {
                Image(language.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                
                VStack {
                    Spacer()
                    HStack {
                        Text(cardNames[language]!)
                            .font(.manropeBold(size: 24))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding()
                }
            }
            .padding(.top, 7.5)
        }
    }
}
