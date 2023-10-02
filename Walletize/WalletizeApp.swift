//
//  WalletizeApp.swift
//  Walletize
//
//  Created by Yap Justin on 02/10/23.
//

import SwiftUI

@main
struct WalletizeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
