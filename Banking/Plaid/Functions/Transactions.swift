//
//  Fetching Transactions.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/11/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import Alamofire

extension PlaidLinkData {
	
	func fetchTransactions(for accountID: [String]) {
		guard userData != nil else { return }
		let endPoint = "transactions/get"
		let url = host + endPoint
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		
		let today = dateFormatter.string(from: Date())
		let twoYearsFromToday = dateFormatter.string(from: Calendar.current.date(byAdding: DateComponents(year: -2), to: Date())!)
		
		for bankInstitution in userData!.wrappedValue.bankInstitutions {
			guard let accessToken = bankInstitution.plaidAccessToken else { continue }
			let parameters: [String : String] = [
				ParameterTitles.clientID : Parameters.clientID,
				ParameterTitles.secret: secret,
				ParameterTitles.accessToken: accessToken,
				"start_date": twoYearsFromToday,
				"end_date": today
			]
			
			AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Parameters.headers).responseJSON { response in
				
				if let data = response.data {
					if let transactionData = try? JSONDecoder().decode(Transactions.self, from: data) {
						DispatchQueue.main.async {
							for transaction in transactionData.transactions {
								self.userData!.wrappedValue.transactions.append(transaction)
								
								let dateFormatter = DateFormatter()
								dateFormatter.dateFormat = "yyyy-MM-dd"
								guard let date = dateFormatter.date(from: transaction.date) else { continue }
								
								let timelineEvent = TimelineEvent(eventID: UUID(), date: date, type: .transaction, transaction: transaction)
								self.userData!.wrappedValue.timeline.events.append(timelineEvent)
							}
						}
					}
				}
			}
		}
	}
	
	func fetchTransactionsForAllAccounts() {
		
	}
	
}
