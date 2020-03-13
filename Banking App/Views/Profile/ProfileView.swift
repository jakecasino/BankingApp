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
    
    var body: some View {
        VStack {
            NavigationView {
                List {
					ForEach(self.$userData.bankInstitutions.wrappedValue, id: \.id) { (bankInstitution: BankInstitution) in
						Section(header: Text(bankInstitution.name.unsafelyUnwrapped)) {
							ForEach(Array(bankInstitution.accounts.unsafelyUnwrapped.allObjects) as! [BankAccount], id: \.id) { (account: BankAccount) in
								Text(account.name.unsafelyUnwrapped)
							}
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
                        .edgesIgnoringSafeArea(.all)
                })
                .navigationBarTitle(Text("Accounts"))
            }
        }
    }
}


// MARK: - Previews

struct ProfileView_Previews: PreviewProvider {
	static var previews: some View {
		let previewData = ProfileView_PreviewsData()
		
		return ProfileView()
			.environmentObject(previewData.userData)
			.environmentObject(previewData.plaidLinkData)
			.previewLayout(.sizeThatFits)
	}
}

fileprivate class ProfileView_PreviewsData {
    @State var userData = UserData()
    @State var plaidLinkData = PlaidLinkData(developerMode: .sandbox)
    
    init() {
        userData.plaidLinkData = $plaidLinkData
        plaidLinkData.userData = $userData
        
		let sampleBankAccounts = [
			userData.addSampleBankAccount(name: "Plaid Checking")
		]
		userData.addSampleBankInstitution(name: "Plaid Banking", bankAccounts: sampleBankAccounts)
    }
}

fileprivate extension UserData {
	func addSampleBankInstitution(name: String, bankAccounts: [BankAccount]) {
        let sampleBankInstitution = BankInstitution(context: context)
        sampleBankInstitution.id  = UUID()
        sampleBankInstitution.name = name
		
		bankAccounts.forEach { (bankAccount) in
			sampleBankInstitution.addToAccounts(bankAccount)
		}
		
        bankInstitutions.append(sampleBankInstitution)
    }
	
	func addSampleBankAccount(name: String) -> BankAccount {
        let bankAccount = BankAccount(context: context)
        bankAccount.name = name
		
		return bankAccount
    }
}
