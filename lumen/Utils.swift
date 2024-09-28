//
//  Utils.swift
//  lumen
//
//  Created by Jeremiah Lena on 28/09/2024.
//

import Foundation

struct CurrencyFormatter {
    static func format(amount: Double, locale: Locale? = Locale.current) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        if let formattedAmount = formatter.string(from: NSNumber(value: amount)) {
            return formattedAmount
        }
        
        return String(format: "%.2f", amount)
    }
}
