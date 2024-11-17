import SwiftUI

struct WelcomeView: View {
    var showRegistration: (() -> ())?
    var showLogin: (() -> ())?
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Spacer()
                    Text("Welcome")
                        .font(.custom("Manrope-Bold", size: 54))
                        .multilineTextAlignment(.center)
                    
                    Text("Unlock worlds through words.")
                        .font(.custom("Manrope-Regular", size: 24))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
                .frame(minHeight: 500)
            }
            VStack {
                Spacer()
                NextButton(title: "Sign up", action: showRegistration)
                Text("Already have and account?")
                    .onTapGesture(perform: showLogin!)
            }
            .padding(.bottom, 30)
            .ignoresSafeArea()
        }
        .padding()
    }
}
