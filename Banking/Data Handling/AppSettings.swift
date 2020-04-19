//
//  SettingsBundleKeys.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 4/18/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import Foundation

struct AppSettings {
	var prefersUnlockWithBiometrics: Bool {
		didSet {
			if oldValue == false {
				if prefersUnlockWithBiometrics == true {
					authenticateWithBiometrics(ifSuccess: {
						UserDefaults.standard.set(true, forKey: AppSettings.BundleKeys.UnlockWithBiometrics)
					}, ifError: {
						UserDefaults.standard.set(false, forKey: AppSettings.BundleKeys.UnlockWithBiometrics)
					})
					
				}
			}
		}
	}
	
	struct BundleKeys {
		static let UnlockWithBiometrics = "UNLOCK_WITH_BIOMETRICS"
	}
}
