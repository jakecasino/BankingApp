//
//  PreviewData.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/13/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI

class PreviewData {
	@State var userData = UserData()
    @State var plaidLinkData = PlaidLinkData()
    
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

// Commit Test
