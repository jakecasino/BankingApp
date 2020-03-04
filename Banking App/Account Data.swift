//
//  Account Data.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 2/28/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import Foundation

/*

struct Accounts: Decodable {
    var accounts: [Account]
    var item: Item
    var requestID: String
    
    enum CodingKeys: String, CodingKey {
        case accounts = "accounts"
        case item = "item"
        case requestID = "request_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accounts = try container.decode([Account].self, forKey: .accounts)
        self.item = try container.decode(Item.self, forKey: .item)
        self.requestID = try container.decode(String.self, forKey: .requestID)
    }
}

struct Item: Decodable {
    var availableProducts: [String]
    var billedProducts: [String]
    var consentExpirationTime: String?
    var error: String?
    var institutionID: String
    var itemID: String
    var webhook: String
    
    enum CodingKeys: String, CodingKey {
        case availableProducts = "available_products"
        case billedProducts = "billed_products"
        case consentExpirationTime = "consent_expiration_time"
        case error = "error"
        case institutionID = "institution_id"
        case itemID = "item_id"
        case webhook = "webhook"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.availableProducts = try container.decode([String].self, forKey: .availableProducts)
        self.billedProducts = try container.decode([String].self, forKey: .billedProducts)
        self.consentExpirationTime = try container.decode(String.self, forKey: .consentExpirationTime)
        self.error = try container.decode(String.self, forKey: .error)
        self.institutionID = try container.decode(String.self, forKey: .institutionID)
        self.itemID = try container.decode(String.self, forKey: .itemID)
        self.webhook = try container.decode(String.self, forKey: .webhook)
    }
}

struct Account: Decodable {
    var accountID: String
    var mask: String
    var name: String
    var officialName: String
    var subtype: String
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case accountID = "account_id"
        case balances = "balances"
        case mask = "mask"
        case name = "name"
        case officialName = "official_name"
        case subtype = "subtype"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accountID = try container.decode(String.self, forKey: .accountID)
        self.balances = try container.decode(AccountBalance.self, forKey: .balances)
        self.mask = try container.decode(String.self, forKey: .mask)
        self.name = try container.decode(String.self, forKey: .name)
        self.officialName = try container.decode(String.self, forKey: .officialName)
        self.subtype = try container.decode(String.self, forKey: .subtype)
        self.type = try container.decode(String.self, forKey: .type)
    }
}

struct AccountBalance: Decodable {
    var available: Double
    var current: Double
    var isoCurrencyCode: String
    var limit: String?
    var unofficialCurrencyCode: String?
    
    enum CodingKeys: String, CodingKey {
        case available = "available"
        case current = "current"
        case isoCurrencyCode = "iso_currency_code"
        case limit = "limit"
        case unofficialCurrencyCode = "unofficial_currency_code"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.available = try container.decode(Double.self, forKey: .available)
        self.current = try container.decode(Double.self, forKey: .current)
        self.isoCurrencyCode = try container.decode(String.self, forKey: .isoCurrencyCode)
        self.limit = try container.decode(String.self, forKey: .limit)
        self.unofficialCurrencyCode = try container.decode(String.self, forKey: .unofficialCurrencyCode)
    }
}
*/
