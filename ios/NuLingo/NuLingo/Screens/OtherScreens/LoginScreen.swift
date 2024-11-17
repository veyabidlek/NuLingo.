//
//  LoginScreen.swift
//  NuLingo
//
//  Created by Batyr Tolkynbayev on 16.11.2024.
//

import SwiftUI

struct LoginScreen: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    var action: (() -> ())?
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 5) {
                    Spacer()
                    Text("Welcome Back!")
                        .font(.custom("Manrope-Bold", size: 40))
                    Spacer(minLength: 20)
                    Textfield(text: $username, placeholder: "Username")
                    Textfield(text: $password, placeholder: "Password")
                }
                .frame(minHeight: 300)
            }
            VStack {
                Spacer()
                NextButton(title: "Login") {
                    print(username)
                    print(password)
                    action?()
                }
            }
            .padding(.bottom, 57.5)
        }
        .padding()
    }
}
