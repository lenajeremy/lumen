//
//  Item.swift
//  lumen
//
//  Created by Jeremiah Lena on 26/09/2024.
//

import Foundation
import SwiftData

@Model
final class TransactionEntry: Identifiable {
    var id: UUID
    var dateCreated: Date
    var amount: Double
    var category: TransactionCategory
    var nameOfExpense: String
    var desc: String?
    
    init(amount: Double, category: TransactionCategory, nameOfExpense: String, description: String?) {
        self.id = UUID()
        self.dateCreated = Date()
        self.amount = amount
        self.category = category
        self.nameOfExpense = nameOfExpense
        self.desc = description
    }
    
    static var defaultTransaction = defaultTransactions.first!
    
    static var defaultTransactions: [TransactionEntry] = [
        TransactionEntry(amount: 9.99, category: entertainment, nameOfExpense: "AppleTV", description: "Netflix Subscription for the month of Sepetember"),
        TransactionEntry(amount: 20.00, category: software, nameOfExpense: "ChatGPT subscription", description: "Subscription for chatgpt"),
        TransactionEntry(amount: 20.00, category: feeding, nameOfExpense: "Breakfast", description: "Got Breakfast"),
        TransactionEntry(amount: 4.0, category: feeding, nameOfExpense: "Coffee", description: "Got myself a cup of coffee")
    ]
}

@Model
final class TransactionCategory {
    var name: String
    var icon: String
    
    init(name: String, icon: String) {
        self.name = name
        self.icon = icon
    }
    
    static var defaultCategory = defaultCategories.first!
    static var defaultCategories: [TransactionCategory] = [
        entertainment,
        miscellaneous,
        feeding,
        transportation,
        software
    ]
}

let entertainment = TransactionCategory(name: "Entertainment", icon: "appletv")
let miscellaneous = TransactionCategory(name: "Miscellaneous", icon: "diamond.fill")
let feeding = TransactionCategory(name: "Feeding", icon: "fork.knife")
let transportation = TransactionCategory(name: "Transportation", icon: "car.fill")
let software = TransactionCategory(name: "Software", icon: "iphone")
