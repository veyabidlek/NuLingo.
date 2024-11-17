import SwiftUI

struct SentenceView: View {
    var group: DispatchGroup
    var language: Language
    var category: String
    var categoryTitle: String
    @StateObject private var viewModel = SentenceViewModel.shared
    @State private var currentIndex: Int = 0
    private let totalCards = 30
    
    var body: some View {
        VStack {
            HStack {
                Text(categoryTitle)
                    .font(.manropeBold(size: 24))
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding(.horizontal)
            
            Spacer()
            
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .font(.manropeRegular(size: 18))
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            } else {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.sentences[Category(rawValue: category.lowercased()) ?? .generate_random]?.dropFirst(currentIndex).prefix(1) ?? [], id: \.id) { sentence in
                            VStack(spacing: 12) {
                                
                                cardView(text: languageSpecificText(sentence), translation: "")
                                
                                cardView(text: sentence.english, translation: "")
                            }
                        }
                    }
                    .frame(minHeight: 500)
                }
                .scrollIndicators(.hidden)
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    if currentIndex > 0 {
                        currentIndex -= 1
                    }
                }) {
                    Text("Previous")
                        .font(.manropeSemiBold(size: 18))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                Text("\(currentIndex + 1)/\(totalCards)")
                    .font(.manropeRegular(size: 16))
                    .foregroundColor(.gray)
                
                Spacer()
                
                Button(action: {
                    if currentIndex + 1 < totalCards {
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
            }
            .padding()
        }
    }
    
    private func languageSpecificText(_ sentence: Sentence) -> String {
        switch language {
        case .kazakh:
            return sentence.kazakh
        case .turkish:
            return sentence.turkish
        case .russian:
            return sentence.russian
        }
    }
    
    // Card View
    private func cardView(text: String, translation: String) -> some View {
        VStack(spacing: 16) {
            Text(text)
                .font(.manropeSemiBold(size: 20))
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .background(Color(uiColor: .systemGray5))
        .cornerRadius(20)
        .padding()
    }
}
