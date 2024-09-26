//
//  ContentView.swift
//  lumen
//
//  Created by Jeremiah Lena on 26/09/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var transactions: [TransactionEntry]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(transactions) { transaction in
                    NavigationLink {
                        Text("Transaction: \(transaction.nameOfExpense) at \(transaction.dateCreated, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        HStack {
                            Text(transaction.nameOfExpense)
                            Text(transaction.dateCreated, format: Date.FormatStyle(date: .numeric, time: .standard))
                        }
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [TransactionEntry.self, TransactionCategory.self], inMemory: true)
}
