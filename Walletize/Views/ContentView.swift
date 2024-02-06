//
//  ContentView.swift
//  Walletize
//
//  Created by Yap Justin on 01/02/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var contentViewModel = ContentViewModel()
    @State private var isPresented = true
    
    var body: some View {
        MainView()
            .fullScreenCover(isPresented: $isPresented) {
                LoginView()
            }
            .onChange(of: contentViewModel.token) {
                if contentViewModel.token != nil {
                    isPresented = false
                } else {
                    isPresented = true
                }
            }
    }
}

#Preview {
    ContentView()
}
