//
//  Home.swift
//  lumen
//
//  Created by Jeremiah Lena on 26/09/2024.
//

import SwiftUI
import SwiftData

struct Home: View {
    @Environment(\.modelContext) private var modelContext
    @Query var transactions: [TransactionEntry]
    
    var body: some View {
        List(transactions) { transaction in
            NavigationLink {
                EditTransactionEntry(transaction: transaction)
            } label: {
                TransactionEntryView(transaction: transaction)
            }
        }
        .navigationTitle("Transactions")
        
    }
}

#Preview {
    Home()
}
