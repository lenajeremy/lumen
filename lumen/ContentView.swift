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
    @State var selectedTab: TabType = .home

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
    let container = setupPreviewContainer()
    ContentView()
        .modelContainer(container)
}

@MainActor
func setupPreviewContainer() -> ModelContainer {
    let schema = Schema([TransactionEntry.self, TransactionCategory.self])
    let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: schema, configurations: [configuration])
    
    // Insert default categories
    for category in TransactionCategory.defaultCategories {
        container.mainContext.insert(category)
    }
    
    // Insert default transactions
    for entry in TransactionEntry.defaultTransactions {
        container.mainContext.insert(entry)
    }
    
    return container
}
