//
//  Initialize Core Data.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/12/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import CoreData

extension UserData {
	
	func initializeCoreData() {
//		fetchAppSettingsFromCoreData()
		fetchLinkedBankInstitutionsFromCoreData()
	}
	
	
//	fileprivate func fetchAppSettingsFromCoreData() {
//		if let allFetchedAppSettings = try? context.fetch(AppSettings.fetchRequest()) as? [AppSettings] {
//			if let fetchedAppSettings  = allFetchedAppSettings.first  {
//				appSettings = fetchedAppSettings
//			} else {
//				appSettings = AppSettings(context: context)
//				appSettings.id = UUID()
//				appSettings.prefersUnlockWithFaceID = false
//				self.saveContext()
//			}
//		}
//	}
	
	fileprivate func fetchLinkedBankInstitutionsFromCoreData() {
		guard let fetchedBankInstitutions = try? context.fetch(BankInstitution.fetchRequest()) as? [BankInstitution] else {
			fatalError("Could not read anything from Core Data.")
		}
		
		fetchedBankInstitutions.forEach { (fetchedBankInstitution) in
			self.bankInstitutions.append(fetchedBankInstitution)
		}
	}
}
