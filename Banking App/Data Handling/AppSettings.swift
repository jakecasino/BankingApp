//
//  SettingsBundleKeys.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 4/18/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import Foundation

struct AppSettings {
	var unlockWithBiometrics: Bool {
		didSet {
			UserDefaults.standard.set(self.unlockWithBiometrics, forKey: AppSettings.BundleKeys.UnlockWithBiometrics)
		}
	}
	
	struct BundleKeys {
		static let UnlockWithBiometrics = "UNLOCK_WITH_BIOMETRICS"
	}
}
