//
//  TransactionsView.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/2/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct TransactionsView: View {
    @EnvironmentObject var userData: UserData
    @State var showTransactionDetailView = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                Text("Transactions".uppercased())
                    .kerning(UIFont.preferredFont(forTextStyle: .body).pointSize * 0.2)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "line.horizontal.3.decrease.circle.fill")
                        .font(.title)
                }
                .accentColor(Color(UIColor.tertiaryLabel))
            }
                .padding(.top, 50.0)
                .padding(.horizontal,  30.0)
            SectionHeader(title: "Recents")
            VStack(spacing: 15.0) {
                ForEach(self.userData.transactions, id: \.name) { transaction in
                    TransactionButton_Compact(transaction: transaction)
                        .environmentObject(self.userData)
                }
            }
            // SectionHeader(title: "More")
            // Spacer()
        }
        .sheet(isPresented: $showTransactionDetailView) {
            TransactionDetailView(transaction: Transaction(account_id: "", name: "Golden Crepes", amount: 24.0, date: "2020-03-03", payment_channel: "online"))
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
			.environmentObject(Sample().userData)
            .previewLayout(.sizeThatFits)
    }
}
