//
//  Transaction.swift
//  Banking App
//
//  Created by Jake Bryan Casino on 3/3/20.
//  Copyright © 2020 Jake Bryan Casino. All rights reserved.
//

import Foundation

struct Transactions: Decodable {
	var transactions: [Transaction]
}

public struct Transaction: Decodable {
    var account_id: String
    var name: String
    var amount: Double
    var category: [String]?
    var location: TransactionLocation?
    var date: String
    var payment_channel: String
}

struct TransactionLocation: Decodable {
    var address: String?
    var city: String?
    var postal_code: String?
    var country: String?
}

public func TransactionCategoryGlyph(for transaction: Transaction) -> String {
    guard let category = transaction.category else { return "gift" }
    guard let lastCategory = category.last else { return "gift" }
    
    switch lastCategory {
        case "Airlines and Aviation Services":
            return "airplane"
        case "Credit Card":
            return "creditcard"
        case "Credit", "Debit", "Deposit", "Payroll":
            return "dollarsign.circle"
        case "Gyms and Fitness Centers":
            return "heart"
        case "Payment":
            return "dollarsign.square"
        case "Sporting Goods":
            return "sportscourt"
        case "Taxi":
            return "car"
        default:
            return "gift"
    }
}

public func formatDate(string: String) -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"

    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd MMM yyyy"

    if let date = dateFormatterGet.date(from: string) {
        return dateFormatterPrint.string(from: date)
    } else {
        return "Some Time Ago"
    }
}
