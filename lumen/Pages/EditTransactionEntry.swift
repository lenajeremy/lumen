//
//  EditTransactionEntry.swift
//  lumen
//
//  Created by Jeremiah Lena on 26/09/2024.
//

import SwiftUI

struct EditTransactionEntry: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State var transaction: TransactionEntry
    
    @State private var amount: Double = 0
    @State private var expenseName: String = ""
    @State private var category: TransactionCategory? = nil
    @State private var description: String = ""
    @State private var dateCreated = Date()
    
    
    var body: some View {
            List {
                TextField("Name of expense", text: $transaction.nameOfExpense)
                TextField("Amount spent", text: Binding(
                    get: {
                        String(format: "%.2f", transaction.amount)
                    },
                    set: { newValue in
                        if let floatValue = Double(newValue) {
                            transaction.amount = floatValue
                        }
                    }
                ))
                .keyboardType(.decimalPad)
                Picker("Category", selection: $transaction.category) {
                    ForEach(TransactionCategory.defaultCategories) { category in
                        Text(category.name).tag(category)
                    }
                }
                
                DatePicker("Date", selection: $transaction.dateCreated, displayedComponents: .date)
                
                TextField("Description", text: $transaction.desc,  axis: .vertical)
                    .lineLimit(5...10)
                
                Button {
                    try? modelContext.save()
                    
                    transaction.amount = 0
                    transaction.category = .defaultCategory
                    transaction.desc = ""
                    transaction.nameOfExpense = ""
                    transaction.dateCreated = Date()
                    
                    dismiss()
                } label: {
                    Text("Save Transaction")
                }
            }
            .navigationTitle("Edit Transaction")
    }
}

#Preview {
    EditTransactionEntry(transaction: TransactionEntry.defaultTransaction)
}
