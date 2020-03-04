//
//  TransactionButton_Compact.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/2/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct TransactionButton_Compact: View {
    @EnvironmentObject var userData: UserData
    @State var showTransactionDetailView = false
    let transaction: Transaction
    
    var body: some View {
        Button(action: {
            self.showTransactionDetailView = true
        }) {
            VStack(spacing: 5.0) {
                HStack {
                    Spacer()
                    Image(systemName: TransactionCategoryGlyph(for: transaction))
                        .font(.caption)
                }
                Text(transaction.name.capitalized)
                Text(String(format: "$%.0f", transaction.amount))
                    .font(.caption)
                    .foregroundColor(Color(UIColor.secondaryLabel))
                    .padding(.bottom, 10.0)
            }
            .padding(.all, 20.0)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10.0, antialiased: true)
        }
        .accentColor(Color(UIColor.label))
        .sheet(isPresented: $showTransactionDetailView) {
            TransactionDetailView(transaction: self.transaction)
                .environmentObject(self.userData)
        }
        .contextMenu {
            VStack {
                Button(action: {
                    self.showTransactionDetailView = true
                }) {
                    HStack {
                        Text("View Transaction")
                        Image(systemName: "eye")
                    }
                }
            }
        }
        .padding(.horizontal, 20.0)
    }
}

struct TransactionButton_Compact_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TransactionButton_Compact(transaction: Transaction(account_id: "", name: "Golden Crepes", amount: 24.0, date: "2020-03-03", payment_channel: "online"))
        }
        .previewLayout(.sizeThatFits)
    }
}
