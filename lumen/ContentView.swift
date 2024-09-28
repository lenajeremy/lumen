//
//  ContentView.swift
//  lumen
//
//  Created by Jeremiah Lena on 26/09/2024.
//

import SwiftUI
import SwiftData

enum TabType: String {
    case home, add, settings
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var transactions: [TransactionEntry]
    @State var selectedTab: TabType = .settings

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "creditcard.and.123", value: .home) {
                Home()
            }
            
            Tab("Add Entry", systemImage: "plus.rectangle.portrait.fill", value: .add) {
                AddNewTransaction {
                    selectedTab = .home
                }
            }
            
            Tab("Settings", systemImage: "gear", value: .settings) {
                Settings()
            }
        }
        .tint(.green)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [TransactionEntry.self, TransactionCategory.self], inMemory: true)
}
