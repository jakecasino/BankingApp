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
					Toggle("Sign In with FaceID", isOn: self.$userData.appSettings.unlockWithBiometrics)
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
		let previewData = PreviewData()
		
		return ProfileView()
			.environmentObject(previewData.userData)
			.environmentObject(previewData.plaidLinkData)
			.previewLayout(.sizeThatFits)
	}
}
