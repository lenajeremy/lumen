//
//  Item.swift
//  lumen
//
//  Created by Jeremiah Lena on 26/09/2024.
//

import Foundation
import SwiftData

@Model
final class TransactionEntry {
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
}

@Model
final class TransactionCategory {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
