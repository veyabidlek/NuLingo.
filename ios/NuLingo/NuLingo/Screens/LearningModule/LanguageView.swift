import SwiftUI

struct LanguageView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var router: MainRouter
    var language: Language
    var cardNames: [Language : String]
    
    let categories: [String] = [
        "Animals",
        "Family",
        "Religion",
        "Activity",
        "Finance",
        "Technology",
        "Food",
        "Sport",
        "Drinks",
        "Generate!"
    ]
    
    let emoji: [String: String] = [
        "Animals" : "🦌",
        "Family" : "👨‍👩‍👧",
        "Religion" : "🕌",
        "Activity" : "⚽️",
        "Finance" : "💵",
        "Technology" : "💻",
        "Food" : "🍗",
        "Sport" : "🥋",
        "Drinks" : "🥤",
        "Generate!" : "🔄"
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text(cardNames[language]!)
                    .font(.manropeBold(size: 32))
                Spacer()
            }
            
            card(isFlashcard: true, title: "Try flashcards!", subTitle: "", background: colorScheme == .dark ? Color(uiColor: .darkGray).opacity(0.4) : Color.customPurple, width: .infinity)
            
            VStack {
                Spacer(minLength: 20)
                HStack {
                    Text("Generated Sentences by categories")
                        .foregroundStyle(.gray)
                        .font(.manropeMedium(size: 18))
                    Spacer()
                }
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(categories, id: \.self) { category in
                            if category == "Generate!" {
                                card(isFlashcard: false, title: category, subTitle: "", background: category != "Generate!" ? Color.gray.opacity(0.2) : (colorScheme == .dark ? Color(uiColor: .darkGray).opacity(0.4) : Color.customPurple), width: .infinity)
                            } else {
                                card(isFlashcard: false, title: emoji[category]!, subTitle: category, background: category != "Generate!" ? Color.gray.opacity(0.2) : (colorScheme == .dark ? Color(uiColor: .darkGray).opacity(0.4) : Color.customPurple), width: .infinity)
                            }
                        }
                    }
                    .padding(.bottom, 16)
                }
                .scrollIndicators(.hidden)
            }
            Spacer()
        }
        .padding(.horizontal, 10)
        .onAppear {
            SentenceViewModel.shared.fetch()
        }
    }
    
    @State private var showingAlert = false
    
    private func card(isFlashcard: Bool, title: String, subTitle: String, background: Color, width: CGFloat) -> some View {
        return Button {
            if isFlashcard {
//                router.openFlashcardView(categoryTitle: "\(title) \(subTitle)")
                showingAlert = true
            } else {
                router.openSentenceView(language: language, category: subTitle, categoryTitle: "\(title) \(subTitle)")
            }
        } label: {
            ZStack {
                Text(title)
                    .font(.manropeSemiBold(size: (title == "Generate!" || isFlashcard) ? (isFlashcard ? 30 : 20) : 40))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                VStack {
                    Spacer()
                    HStack {
                        Text(subTitle)
                            .font(.manropeSemiBold(size: 20))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Spacer()
                    }
                }
                .padding()
            }
            .frame(maxWidth: width, minHeight: 140, maxHeight: 140)
            .background(background)
            .cornerRadius(20)
        }
        .contentShape(Rectangle())
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Soon..."),
                message: Text("This feature will be available soon."),
                primaryButton: .cancel(),
                secondaryButton: .default(Text("Done"))
            )
        }
    }
}
