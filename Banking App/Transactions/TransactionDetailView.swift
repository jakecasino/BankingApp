//
//  TransactionView.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/2/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

struct TransactionDetailView: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode
    let transaction: Transaction
    
    var body: some View {
        ZStack {
            ScrollView {
                TransactionView_Essentials(transaction: transaction)
                    .environmentObject(self.userData)
                Divider()
                TransactionView_CommitmentReview(transaction: transaction)
                // Divider()
                // SimilarTransactions(parent: self)
            }
            VStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                } ) {
                    Image(systemName: "chevron.compact.down")
                        .font(.system(size: 40.0, weight: .semibold, design: .default))
                        .foregroundColor(Color(UIColor.tertiaryLabel))
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                    .padding(.top)
                Spacer()
            }
        }
    }
}

struct TransactionView_Essentials: View {
    @EnvironmentObject var userData: UserData
    let transaction: Transaction
    
    enum Label {
        case amountLabel
        case amount
    }
    
    func label(_ label: Label) -> String {
        let isPurchase = transaction.amount >= 0
        
        switch label {
            case .amountLabel:
                return isPurchase ? "You spent" : "You got"
            case .amount:
                return String(format: "$%.02f", isPurchase ? transaction.amount : transaction.amount * -1.0)
        }
    }
    
    var body: some View {
        VStack(spacing: 30.0) {
            
            // MARK: - Header
            
            HStack {
                Text(formatDate(string: transaction.date).uppercased())
                    .kerning(UIFont.preferredFont(forTextStyle: .caption1).pointSize * 0.2)
                    .font(.system(.caption, design: .monospaced))
                Spacer()
                if transaction.payment_channel == "online" {
                    Text(transaction.payment_channel.uppercased())
                        .kerning(UIFont.preferredFont(forTextStyle: .caption1).pointSize * 0.2)
                        .font(.system(.caption, design: .monospaced))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            // MARK: - Body
            
            VStack(alignment: .leading) {
                Text(transaction.name.capitalized)
					.font(.system(.title, design: .serif))
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom)
                Text(userData.getAccount(forID: transaction.account_id).name.uppercased())
                    .kerning(UIFont.preferredFont(forTextStyle: .caption1).pointSize * 0.2)
                    .font(.system(.caption, design: .monospaced))
                    .multilineTextAlignment(.trailing)
                    .padding(.bottom)
                if transaction.location != nil {
                    MapView(address: transaction.location!.address)
                        .frame(height: 140.0)
                        .cornerRadius(10.0, antialiased: true)
                }
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 10.0) {
                    Text(label(.amountLabel))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                    Text(label(.amount))
                        .font(.system(.title, design: .monospaced))
                        .foregroundColor(Color((transaction.amount >= 0) ? UIColor.label : UIColor.systemGreen))
                        .fontWeight(.bold)
                }
                Spacer()
            }
        }
            .padding(.top, 70.0)
            .padding(.bottom, 30.0)
            .padding(.horizontal, 30.0)
    }
}

struct TransactionView_CommitmentReview: View {
    let transaction: Transaction
    
    var body: some View {
        VStack(spacing: 30.0) {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: TransactionCategoryGlyph(for: transaction))
                        .font(.largeTitle)
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "gear")
                    }
                }
                    .padding(.bottom)
                if transaction.category != nil {
                    Text(transaction.category!.last!)
                }
            }
                .padding(.horizontal, 10.0)
            ZStack {
                HStack(spacing: 0.0) {
                    Rectangle()
                        .foregroundColor(Color(UIColor.systemGray3))
                        .frame(width: 100.0)
                    Rectangle()
                        .foregroundColor(Color(UIColor.systemOrange))
                        .frame(width: 20.0)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("$100")
                        .tracking(UIFont.preferredFont(forTextStyle: .caption1).pointSize * 0.2)
                        .font(.system(.caption, design: .monospaced))
                        .multilineTextAlignment(.trailing)
                        .padding()
                }
            }
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10.0, antialiased: true)
            Text("You used 2% of your Restaurants Commitment for March.")
                .font(.subheadline)
                
        }
            .padding(.horizontal, 20.0)
            .padding(.vertical, 30.0)
    }
}

struct SimilarTransactions: View {
    var parent: TransactionDetailView
    
    var body: some View {
        VStack {
            Text("Similar Purchases")
                .font(.callout)
                .foregroundColor(Color(UIColor.secondaryLabel))
                .padding(.bottom, 20.0)
            TransactionButton(transaction: Transaction(account_id: "", name: "Golden Crepes", amount: 24.0, date: "2020-03-03", payment_channel: "online"))
        }
            .padding(.vertical, 40.0)
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailView(transaction: Transaction(account_id: "", name: "Golden Crepes", amount: 24.0, location: TransactionLocation(address: "6201 Hollywood Blvd, Los  Angeles, CA, 90028"), date: "2020-03-03", payment_channel: "in store"))
            .environmentObject(UserData())
            .previewLayout(.sizeThatFits)
    }
}
