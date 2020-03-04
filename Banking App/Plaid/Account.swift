//
//  Account.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/4/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

struct Account: Decodable {
    var account_id: String
    var name: String
    var balances: AccountBalance
}

struct AccountBalance: Codable, Hashable {
    var current: Double
}
