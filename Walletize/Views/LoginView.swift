//
//  LoginView.swift
//  Walletize
//
//  Created by Yap Justin on 01/02/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading) {
                    Text("Welcome,")
                        .font(Nunito.bold(size: 36))
                    Text("Please log in to continue")
                        .font(Nunito.regular(size: 20))
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(Nunito.regular(size: 16))
                        TextField("", text: $loginViewModel.email)
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
                        SecureField("", text: $loginViewModel.password)
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
                        loginViewModel.login()
                    }, label: {
                        Text("Log in")
                            .font(Nunito.regular(size: 16))
                            .bold()
                            .padding(.horizontal, 40)
                            .padding(.vertical, 10)
                    })
                    .clipShape(.rect(cornerRadius: 100))
                    .buttonStyle(.borderedProminent)
                }
                
                HStack {
                    Spacer()
                    Text("Not on Walletize?")
                        .font(Nunito.regular(size: 16))
                    NavigationLink {
                        SignupView()
                    } label: {
                        Text("Create an account")
                            .font(Nunito.regular(size: 16))
                            .underline()
                    }
                }
            }
            .padding()
            .navigationTitle("Login")
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    LoginView()
}
