//
//  Authenticate with Biometrics.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 4/18/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import Foundation
import LocalAuthentication

extension UserData {
	func updateAppSettings() {
		appSettings.prefersUnlockWithBiometrics = UserDefaults.standard.bool(forKey: AppSettings.BundleKeys.UnlockWithBiometrics)
	}
}

public func authenticateWithBiometrics(ifSuccess successCompletion: @escaping () -> (), ifError errorCompletion: (() -> ())?) {
	let context = LAContext()
	var error: NSError?

	if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
		
		let reason = "We need to unlock your data."

		context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
			
			DispatchQueue.main.async {
				if success { successCompletion() }
				else if let errorCompletion = errorCompletion { errorCompletion() }
			}
		}
	}
}
