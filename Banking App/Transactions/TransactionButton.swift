//
//  TransactionButton_Compact.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/2/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct TransactionButton: View {
    @EnvironmentObject var userData: UserData
    @State var showTransactionDetailView = false
    let transaction: Transaction
    
    var body: some View {
        Button(action: {
            self.showTransactionDetailView = true
        }) {
			VStack(alignment: .leading, spacing: 5.0) {
				HStack(alignment: .top) {
					Image(systemName: TransactionCategoryGlyph(for: transaction))
						.frame(width: 40, height: 40)
						.background(Color(UIColor.systemIndigo))
						.cornerRadius(40 / 2)
						.foregroundColor(Color(UIColor.systemBackground))
						.padding(.bottom)
					Spacer()
					Text("1 day ago")
						.font(.caption)
						.foregroundColor(Color(UIColor.secondaryLabel))
				}
                Text(transaction.name.capitalized)
					.padding(.bottom, 10.0)
                Text(String(format: "$%.0f", transaction.amount))
					.font(.system(.callout, design: .monospaced))
                    .foregroundColor(Color(UIColor.secondaryLabel))
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
			Button(action: {
				self.showTransactionDetailView = true
			}) {
				HStack {
					Text("View Transaction")
					Image(systemName: "eye")
				}
			}
        }
        .padding(.horizontal, 20.0)
    }
}

struct TransactionButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TransactionButton(transaction: Transaction(account_id: "0", name: "Golden Crepes", amount: 24.0, date: "2020-03-03", payment_channel: "online"))
        }
		.environmentObject(UserData())
        .previewLayout(.sizeThatFits)
    }
}
