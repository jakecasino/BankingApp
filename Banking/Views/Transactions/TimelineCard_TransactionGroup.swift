//
//  TMLTransactionGroupCard.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/10/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct TimelineCard_TransactionGroup: View {
    @EnvironmentObject var userData: UserData
	@State var showTransactionDetailView = false
    let transaction: Transaction
	
    var body: some View {
		VStack(spacing: 50) {
			Text("You spent $80 last week.")
			
			ZStack(alignment: .top) {

				TMLCard() {
					Rectangle()
						.foregroundColor(Color.clear)
						.frame(minWidth: 0, maxWidth: .infinity)
						.frame(height: 100)
				}
					.offset(y: -45)
					.scaleEffect(0.9 * 0.9)
					.opacity(0.4)

				TMLCard() {
					Rectangle()
						.foregroundColor(Color.clear)
						.frame(minWidth: 0, maxWidth: .infinity)
						.frame(height: 100)
				}
					.offset(y: -20)
					.scaleEffect(0.9)
					.opacity(0.8)

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
					
				}
			}
		}
		.padding()
		.background(Color(UIColor.quaternarySystemFill))
		.clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
	}
}

struct TimelineCard_TransactionGroup_Previews: PreviewProvider {
    static var previews: some View {
        TimelineCard_TransactionGroup(transaction: Transaction(account_id: "0", name: "Golden Crepes", amount: 24.0, date: "2020-03-03", payment_channel: "online"))
			.previewLayout(.sizeThatFits)
    }
}
