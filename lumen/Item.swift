//
//  Item.swift
//  lumen
//
//  Created by Jeremiah Lena on 26/09/2024.
//

import SwiftUI
import Foundation
import SwiftData


@Model
final class TransactionEntry: Identifiable {
    var id: UUID
    var dateCreated: Date
    var amount: Double
    var category: TransactionCategory
    var nameOfExpense: String
    var desc: String

    init(amount: Double, category: TransactionCategory, nameOfExpense: String, description: String = "", dateCreated: Date = Date()) {
        self.id = UUID()
        self.dateCreated = dateCreated
        self.amount = amount
        self.category = category
        self.nameOfExpense = nameOfExpense
        self.desc = description
    }

    static var defaultTransaction: TransactionEntry {
        defaultTransactions.first!
    }

    static var defaultTransactions: [TransactionEntry] = {
        var transactions = [TransactionEntry]()
        let categories = [entertainment, software, feeding, transportation, miscellaneous]
        let expenseNames = ["Subscription", "Lunch", "Taxi", "Groceries", "Coffee", "Movie", "App Purchase", "Gym", "Dinner", "Shopping"]
        let descriptions = [
            "Netflix subscription", "Monthly gym fee", "Dinner with friends",
            "Coffee on the go", "Bought a new app", "Groceries for the week",
            "Taxi to work", "Weekend outing", "Breakfast at the cafe", "Late-night snack"
        ]
        
        // Create 50 transactions spanning a week
        for dayOffset in 0..<7 {
            let currentDate = Calendar.current.date(byAdding: .day, value: -dayOffset, to: Date())!
            for _ in 0..<7 {  // Create 7 transactions per day
                let randomAmount = Double.random(in: 3.0...50.0)
                let randomCategory = categories.randomElement()!
                let randomExpense = expenseNames.randomElement()!
                let randomDescription = descriptions.randomElement()!
                let transaction = TransactionEntry(
                    amount: randomAmount,
                    category: randomCategory,
                    nameOfExpense: randomExpense,
                    description: randomDescription
                )
                transaction.dateCreated = currentDate  // Set the date for this transaction
                transactions.append(transaction)
            }
        }
        return transactions
    }()
}

@Model
final class TransactionCategory: Hashable {
    var name: String
    var icon: String
    var colorHex: String
    
    init(name: String, icon: String, color: String) {
        self.name = name
        self.icon = icon
        self.colorHex = color
    }
    
    static func == (lhs: TransactionCategory, rhs: TransactionCategory) -> Bool {
        return lhs.name == rhs.name && lhs.icon == rhs.icon
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.icon)
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

extension Color {
    init?(hex: String) {
        // Remove any prefix like # if present
        let r, g, b: Double
        var hexColor = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexColor.hasPrefix("#") {
            hexColor.removeFirst()
        }

        // Check for valid hex length
        var rgb: UInt64 = 0
        Scanner(string: hexColor).scanHexInt64(&rgb)

        switch hexColor.count {
        case 3: // RGB (e.g. #RGB)
            r = Double((rgb & 0xF00) >> 8) / 15.0
            g = Double((rgb & 0x0F0) >> 4) / 15.0
            b = Double(rgb & 0x00F) / 15.0
        case 6: // RGB (e.g. #RRGGBB)
            r = Double((rgb & 0xFF0000) >> 16) / 255.0
            g = Double((rgb & 0x00FF00) >> 8) / 255.0
            b = Double(rgb & 0x0000FF) / 255.0
        default:
            return nil // Invalid hex string
        }

        self.init(red: r, green: g, blue: b)
    }
    
    func toHex() -> String {
            // Convert Color to UIColor to access its RGBA components
            let uiColor = UIColor(self)
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            
            // Get the color components
            uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            // Convert components to hex string
            let r = Int(red * 255)
            let g = Int(green * 255)
            let b = Int(blue * 255)
            
            // Format to hex string
            return String(format: "#%02X%02X%02X", r, g, b)
        }
}


let entertainment = TransactionCategory(name: "Entertainment", icon: "appletv", color: Color.pink.toHex())
let miscellaneous = TransactionCategory(name: "Miscellaneous", icon: "diamond.fill", color: Color.blue.toHex())
let feeding = TransactionCategory(name: "Feeding", icon: "fork.knife", color: Color.indigo.toHex())
let transportation = TransactionCategory(name: "Transportation", icon: "car.fill", color: Color.green.toHex())
let software = TransactionCategory(name: "Software", icon: "iphone", color: Color.orange.toHex())
