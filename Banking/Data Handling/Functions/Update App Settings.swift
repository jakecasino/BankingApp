//
//  Update App Settings.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 4/17/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI
import CoreData
import LocalAuthentication

extension UserData {
//	func updateAppSettings(prefersUnlockWithFaceID: Bool) {
//
//		guard prefersUnlockWithFaceID else { return }
//		guard let allFetchedAppSettings = try? context.fetch(AppSettings.fetchRequest()) as? [AppSettings] else {
//			fatalError("Could not read anything from Core Data.")
//		}
//		guard let fetchedAppSettings  = allFetchedAppSettings.first else {
//			fatalError("Could not read anything from Core Data.")
//		}
//
//		// Face ID Authentication
//
//		let context = LAContext()
//		var error: NSError?
//
//
//		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//
//			let reason = "We need to unlock your data."
//
//			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
//
//				DispatchQueue.main.async {
//					if success {
//						fetchedAppSettings.prefersUnlockWithFaceID.toggle()
//						self.saveContext()
//					} else {
//
//					}
//				}
//			}
//		} else {
//
//		}
//	}
}
