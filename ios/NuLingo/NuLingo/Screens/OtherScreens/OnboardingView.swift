//
//  OnboardingView.swift
//  NuLingo
//
//  Created by Batyr Tolkynbayev on 16.11.2024.
//

import SwiftUI

enum OnboardingStep: String, Identifiable, CaseIterable {
    case learn
    case listen
    case flash
    
    var id: String { self.rawValue }
}

struct OnboardingView: View {
    var completion: (() -> ())?
    
    var body: some View {
        VStack {
            TabView {
                ForEach(OnboardingStep.allCases) {
                    onboardingStepView($0)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle())
            
            NextButton(title: "Get Started!", action: completion)
            Spacer(minLength: 60)
        }
        .ignoresSafeArea()
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    Gradient.Stop(color: Color(hex: "4F43F3"), location: 0.0),
                    Gradient.Stop(color: Color(hex: "3F34D6"), location: 0.6),
                    Gradient.Stop(color: Color(hex: "484D90"), location: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
    
    let onboardingTexts: [OnboardingStep: String] = [
        .learn: "Learn Languages Easily!",
        .listen: "Listen to Correct Pronunciations",
        .flash: "Enjoy Using Flashcards"
    ]
    private func onboardingStepView(_ step: OnboardingStep) -> some View {
        ZStack {
            VStack {
                HStack {
                    if step == .listen {
                        Spacer()
                        Image("\(step.rawValue)1")
                    } else {
                        Image("\(step.rawValue)1")
                        Spacer()
                    }
                }
                Spacer()
                HStack {
                    if step == .listen {
                        Image("\(step.rawValue)2")
                        Spacer()
                    } else if step == .learn {
                        Spacer()
                        Image("\(step.rawValue)2")
                    }
                }
            }
            Text(onboardingTexts[step]!)
                .foregroundStyle(.white)
                .font(.custom("Manrope-ExtraBold", size: 36))
                .frame(width: 320)
                .multilineTextAlignment(.center)
        }
    }
}
