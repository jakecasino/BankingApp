//
//  SaveLinkedBankInstitution.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/12/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//


import SwiftUI
import CoreData

struct LinkedBankInstitutionRecordInformation {
	static let plaidAccessToken = "plaidAccessToken"
}

extension UserData {
	func addBankInstitution(linkedWithPlaidAccessToken plaidAccessToken: String) {
		guard plaidLinkData != nil else { return }
		
		let bankInstitution = BankInstitution(context: context)
		bankInstitution.id  = UUID()
		bankInstitution.plaidAccessToken = plaidAccessToken
		
		plaidLinkData!.wrappedValue.getInstitutionName(withAccessToken: plaidAccessToken) { (institutionName) in
			bankInstitution.name = institutionName
			
			self.plaidLinkData!.wrappedValue.fetchAvailableBankAccounts(withPlaidAccessToken: plaidAccessToken) { bankAccounts in

					bankAccounts.forEach { (bankAccount) in
						bankInstitution.addToAccounts(bankAccount)
					}
					
					self.bankInstitutions.append(bankInstitution)
					
					self.saveContext()
			}
		}
	}
	
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
