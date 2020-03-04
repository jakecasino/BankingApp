//
//  ProfileView.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/2/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI
import Alamofire

struct ProfileView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var plaidLinkData: PlaidLinkData
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    if self.userData.accounts.count > 0 {
                        ForEach(self.userData.accounts, id: \.name) { account in
                            AccountRowView(name: account.name, currentBalance: account.balances.current)
                        }
                        Button(action: {
                            self.$userData.accounts.wrappedValue.append(Account(account_id: "", name: "OneBank", balances: AccountBalance(current: 522.91)))
                        }) {
                            Text("Add New")
                        }
                    }
                }
                .navigationBarItems(trailing: Button(action: {
                    self.$plaidLinkData.showPlaidLinkModal.wrappedValue = true
                }) {
                    Text("Show Plaid")
                }.sheet(isPresented: self.$plaidLinkData.showPlaidLinkModal) {
                    PlaidViewControllerRepresentable()
                        .environmentObject(self.userData)
                        .environmentObject(self.plaidLinkData)
                        .environment(\.managedObjectContext, self.context)
                        .edgesIgnoringSafeArea(.all)
                })
                .navigationBarTitle(Text("Accounts"))
            }
        }
    }
}

struct AccountRowView: View {
    var name: String
    var currentBalance: Double
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text(String(format: "%.2f", currentBalance))
        }
    }
}
