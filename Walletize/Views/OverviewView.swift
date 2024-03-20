//
//  OverviewView.swift
//  Walletize
//
//  Created by Yap Justin on 06/02/24.
//

import SwiftUI

struct OverviewView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Net worth")
                    .font(Nunito.regular(size: 16))
                HStack {
                    Text("$")
                        .font(Nunito.regular(size: 40))
                    Text("1,812,123")
                        .font(Nunito.bold(size: 40))
                }
                
                HStack {
                    Spacer()
                    VStack {
                        Text("Income")
                            .font(Nunito.regular(size: 16))
                        HStack(spacing: 4) {
                            Text("+")
                            Text("$")
                            Text("1,812")
                        }
                        .font(Nunito.bold(size: 24))
                        .foregroundStyle(.green)
                    }
                    Spacer()
                    Divider()
                        .frame(maxHeight: 40)
                    Spacer()
                    VStack {
                        Text("Expenses")
                            .font(Nunito.regular(size: 16))
                        HStack(spacing: 4) {
                            Text("+")
                            Text("$")
                            Text("1,812")
                        }
                        .font(Nunito.bold(size: 24))
                        .foregroundStyle(.pastelRed)
                    }
                    Spacer()
                }
                
                TransactionRowView()
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
              )
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        Spacer()
                        Button("+") {
                            // TODO add transaction
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding(.bottom)
               }
           }
        }
    }
}

#Preview {
    OverviewView()
}
