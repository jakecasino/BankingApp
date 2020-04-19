//
//  PlaidLinkData.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/3/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI
import Alamofire

final class PlaidLinkData: ObservableObject {
	var userData: Binding<UserData>?
    
    @Published var showPlaidLinkModal = false
	
	let host: String
	let secret: String
	
	struct ParameterTitles {
		static let clientID = "client_id"
		static let secret = "secret"
		static let publicKey = "public_key"
		static let publicToken = "public_token"
		static let accessToken = "access_token"
		static let institutionID = "institution_id"
	}
	
	struct Parameters {
		static let headers: HTTPHeaders = ["Content-Type": "application/json"]
		static let publicKey = "def4ad236b8b7c59f32fdf31f1bdb0"
		static let clientID = "5de493c9c72d7b0012cb1f3a"
		static let accessToken = "access_token"
	}
	
	init() {
		
		guard let configurationFile = Bundle.main.path(forResource: "Configuration", ofType: "plist") else {
				fatalError("Could not find Configuration.plist file")
		}
		
		guard let allConfigurations = NSDictionary(contentsOfFile: configurationFile),
			let configurationKey = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String,
			let configuration = allConfigurations[configurationKey] as? [String: Any]
			else {
				fatalError("Could not read Configuration.plist file")
		}
		
		guard let fetchedHost = configuration["PlaidHost"] as? String else {
			print(configuration)
			fatalError("Could not read Plaid Host from Configuration.plist")
		}
		
		guard let fetchedSecret = configuration["PlaidSecret"] as? String else {
			fatalError("Could not read Plaid Secret from Configuration.plist")
		}
		
		host = fetchedHost
		secret = fetchedSecret
		
	}
}
