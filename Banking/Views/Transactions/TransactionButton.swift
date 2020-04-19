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
		TMLCard() {
			VStack(alignment: .leading, spacing: 5.0) {
				HStack(alignment: .top) {
					Image(systemName: TransactionCategoryGlyph(for: self.transaction))
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
				Text(self.transaction.name.capitalized)
					.padding(.bottom, 10.0)
				Text(String(format: "$%.0f", self.transaction.amount))
					.font(.system(.callout, design: .monospaced))
					.foregroundColor(Color(UIColor.secondaryLabel))
			}
			.padding(.all, 20.0)
			// .frame(maxHeight: self.showTransactionDetailView ? .infinity :  nil)
			// .background(Color.red)
		}
		.onTapGesture {
			self.showTransactionDetailView.toggle()
		}
		.sheet(isPresented: self.$showTransactionDetailView) {
			TransactionDetailView(transaction: self.transaction)
				.environmentObject(self.userData)
		}
		.animation(.default)
    }
}

struct TransactionButton_Previews: PreviewProvider {
    static var previews: some View {
		ZStack {
			TransactionButton(transaction: Transaction(account_id: "0", name: "Golden Crepes", amount: 24.0, date: "2020-03-03", payment_channel: "online"))
		}
		.background(Color("background"))
		.environmentObject(UserData())
    }
}
