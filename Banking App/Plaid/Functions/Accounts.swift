//
//  Fetching Accounts.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/11/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import SwiftUI
import Alamofire

extension PlaidLinkData {
	func fetchAvailableBankAccounts(withPlaidAccessToken plaidAccessToken: String, completion: @escaping ([BankAccount]) -> ()) {
		guard userData != nil else { return }
		
		let endPoint = "accounts/get"
		let url = host + endPoint
        
		struct Accounts: Decodable {
            var accounts: [Account]
        }

		struct Account: Decodable {
			var account_id: String
			var name: String
			// var balances: AccountBalance
		}

		struct AccountBalance: Codable, Hashable {
			var current: Double
		}
		
		let parameters: [String : String] = [
			ParameterTitles.clientID : Parameters.clientID,
			ParameterTitles.secret: secret,
			ParameterTitles.accessToken: plaidAccessToken
		]
		
		AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Parameters.headers).responseJSON { response in
			
			if let response = response.data {
				if let data = try? JSONDecoder().decode(Accounts.self, from: response) {
					DispatchQueue.main.async {
						var bankAccounts  = [BankAccount]()
						data.accounts.forEach { (account) in
							
							let bankAccount = BankAccount(context: self.userData!.wrappedValue.context)
							bankAccount.name = account.name
							bankAccount.id = UUID()
							bankAccount.plaidAccountID = account.account_id
							
							bankAccounts.append(bankAccount)
						}
						completion(bankAccounts)
					}
				}
			}
		}
	}
}
