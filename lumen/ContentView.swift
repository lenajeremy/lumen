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
        NavigationView {
            TabView {
                Tab("Transactions", systemImage: "creditcard.and.123") {
                    Home()
                }

                Tab("Add Entry", systemImage: "plus.rectangle.portrait.fill") {
                    AddNewTransaction()
                }

                Tab("Settings", systemImage: "gear") {
                    Settings()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [TransactionEntry.self, TransactionCategory.self], inMemory: true)
}
