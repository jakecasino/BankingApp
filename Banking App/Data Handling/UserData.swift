//
//  UserData.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/3/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI
import CoreData
import Combine
import CloudKit

final class UserData: ObservableObject {
	@Published var timeline = Timeline()
	@Published var bankInstitutions = [BankInstitution]()
	
	var plaidLinkData: Binding<PlaidLinkData>?
    @Published var transactions = [Transaction]()
	
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        
		let container = NSPersistentCloudKitContainer(name: "Banking App")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
		
		guard let description = container.persistentStoreDescriptions.first else {
			fatalError("Could not retrieve a persistent store description.")
		}

		try? container.initializeCloudKitSchema(options: [.dryRun, .printSchema])
		let id = "iCloud.com.jakecasino.Banking-App"
		let options = NSPersistentCloudKitContainerOptions(containerIdentifier: id)
		description.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: id)
		
        return container
    }()
	
	lazy var context = persistentContainer.viewContext
	
}
