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
	
	init(developerMode: DeveloperModes) {
		
		switch developerMode {
		case .development:
			host = "https://development.plaid.com/"
			secret = "915c4e388881a098fc5068f6165cc6"
		case .sandbox:
			host = "https://sandbox.plaid.com/"
			secret = "56b7340726b45dfa709a700277d981"
		default:
			host = "https://sandbox.plaid.com/"
			secret = "56b7340726b45dfa709a700277d981"
		}
	}
}
