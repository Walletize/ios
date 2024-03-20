//
//  TransactionRowView.swift
//  Walletize
//
//  Created by Yap Justin on 07/02/24.
//

import SwiftUI

struct TransactionRowView: View {
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "moon.stars.fill")
            }
            VStack(alignment: .leading) {
                Text("Spotify")
                    .font(Nunito.semibold(size: 20))
                HStack {
                    Text("10:00 am")
                        .font(Nunito.regular(size: 16))
                    Text("Mar 26th 2023")
                        .font(Nunito.regular(size: 16))
                }
            }
            Spacer()
            Text("54.99")
                .font(Nunito.regular(size: 16))
        }
    }
}

#Preview {
    OverviewView()
}
