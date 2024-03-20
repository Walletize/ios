//
//  MainView.swift
//  Walletize
//
//  Created by Yap Justin on 04/02/24.
//

import SwiftUI

struct MainView: View {
    init() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: "Nunito-Bold", size: 11)! ], for: .normal)
    }
    
    var body: some View {
        TabView {
            OverviewView()
                .tabItem {
                    Label("Overview", systemImage: "list.dash")
                }
            AssetsView()
                .tabItem {
                    Image("coins-solid")
                }
            TransactionsView()
                .tabItem {
                    Label("Transactions", systemImage: "list.dash")
                }
            BudgetView()
                .tabItem {
                    Label("Budgets", systemImage: "list.dash")
                }
        }
    }
}

#Preview {
    MainView()
}
