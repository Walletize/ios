//
//  SignupView.swift
//  Walletize
//
//  Created by Yap Justin on 04/02/24.
//

import SwiftUI

struct SignupView: View {
    @StateObject private var signupViewModel = SignupViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading) {
                Text("Welcome,")
                    .font(Nunito.bold(size: 36))
                Text("Please sign up to continue")
                    .font(Nunito.regular(size: 20))
            }
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(Nunito.regular(size: 16))
                    TextField("", text: $signupViewModel.email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .font(Nunito.regular(size: 16))
                        .padding()
                        .clipShape(.rect(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemGray3), lineWidth: 1)
                        )
                }
                VStack(alignment: .leading) {
                    Text("Password")
                        .font(Nunito.regular(size: 16))
                    SecureField("", text: $signupViewModel.password)
                        .font(Nunito.regular(size: 16))
                        .padding()
                        .clipShape(.rect(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemGray3), lineWidth: 1)
                        )
                }
            }
            
            HStack {
                Spacer()
                Button(action: {
                    signupViewModel.signup()
                }, label: {
                    Text("Sign up")
                        .font(Nunito.regular(size: 16))
                        .bold()
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                })
                .clipShape(.rect(cornerRadius: 100))
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

#Preview {
    SignupView()
}
