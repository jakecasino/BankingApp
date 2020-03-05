//
//  UserDataSample.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/4/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import Combine
import Alamofire

final class Sample: ObservableObject  {
    var userData = UserData()
    var plaidLinkData = PlaidLinkData(developerMode: .sandbox)
    
    init() {
        userData.accounts = [Account]()
        userData.transactions = [
            Transaction(account_id: "", name: "Golden Crepes", amount: 24.0, category: ["Taxi"], location: nil, date: "2020-03-03", payment_channel: "online")
        ]
        getTransactions()
    }
    
    func getTransactions() {
        
        let parameters: [String : String] = [
            PlaidAPIParameterTitles.clientID.rawValue : plaidLinkData.clientID,
            PlaidAPIParameterTitles.secret.rawValue: plaidLinkData.secret,
            PlaidAPIParameterTitles.accessToken.rawValue: "access-sandbox-e7ba0491-0f60-4ebb-a963-3b653f680d7f",
            "start_date": "2020-01-01",
            "end_date": "2020-03-03"
        ]
        
        AF.request("\(plaidLinkData.host)transactions/get", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: plaidLinkData.headers).responseJSON { response in
            
            if let data = response.data {
                if let transactionData = try? JSONDecoder().decode(Transactions.self, from: data) {
                    DispatchQueue.main.async {
                        self.userData.transactions = transactionData.transactions
                    }
                }
            }
        }
    }
}
