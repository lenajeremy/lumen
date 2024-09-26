//
//  lumenApp.swift
//  lumen
//
//  Created by Jeremiah Lena on 26/09/2024.
//

import SwiftUI
import SwiftData

@main
struct lumenApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            TransactionEntry.self,
            TransactionCategory.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
    
    func setupDefaultCategories() {
        
    }
}
