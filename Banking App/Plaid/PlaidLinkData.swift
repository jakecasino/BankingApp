//
//  PlaidLinkData.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/3/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI
import CoreData
import Combine
import Alamofire

enum PlaidAPIParameterTitles: String {
    
	case clientID = "client_id"
    case secret = "secret"
    case publicToken = "public_token"
    case accessToken = "access_token"
}

final class PlaidLinkData: ObservableObject {
    var coreDataEntity: NSManagedObject?
    
	let host: String
    let headers: HTTPHeaders = ["Content-Type": "application/json"]
    let publicKey = "def4ad236b8b7c59f32fdf31f1bdb0"
    
    let clientID = "5de493c9c72d7b0012cb1f3a"
    
    // Secrets
	let secret: String
    
    var accessToken: String?
    
    @Published var showPlaidLinkModal = false
	
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
