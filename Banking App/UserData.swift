//
//  UserData.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/3/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import Combine

enum DeveloperModes {
	case sandbox
	case development
	case production
}

final class UserData: ObservableObject {
    @Published var accounts = [Account]()
    @Published var transactions = [Transaction]()
    
    func getAccount(forID id: String) -> Account {
        // var success = false
        var account = Account(account_id: "", name: "Sample", balances: AccountBalance(current: 0.0))
        
        search: for matchingAccount in accounts {
            if id == matchingAccount.account_id {
                account = matchingAccount
                // success = true
                break search
            }
        }
        
        return account
    }
}
