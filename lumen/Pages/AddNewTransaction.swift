//
//  AddNewTransaction.swift
//  lumen
//
//  Created by Jeremiah Lena on 26/09/2024.
//

import SwiftUI

struct AddNewTransaction: View {
    @State private var amount: Double = 0
    @State private var expenseName: String = ""
    @State private var category: TransactionCategory? = nil
    @State private var description: String = ""
    
    var onComplete: () -> Void
    
    @Environment(\.modelContext) private var modelCtx
    
    var body: some View {
        NavigationStack {
            Form {
                LabeledContent{
                    TextField("Bag of champagne", text: $expenseName)
                } label: {
                    Label {
                        Text("Expense: ")
                    } icon: {
                        Image(systemName: "gear")
                    }
                }.labelStyle(.titleOnly)
                
                LabeledContent("Amount:") {
                    TextField("$5", text: Binding(
                        get: {
                            if amount == 0 {
                                return ""
                            } else {
                                return String(format: "%.2f", amount)
                            }
                        },
                        set: { newValue in
                            if let floatValue = Double(newValue) {
                                amount = floatValue
                            }
                        }
                    ))
                    .keyboardType(.decimalPad)
                }
                
                Picker("Category", selection: $category) {
                    ForEach(TransactionCategory.defaultCategories) { category in
                        Text(category.name).tag(category)
                    }
                }
                TextField("Description", text: $description,  axis: .vertical)
                    .lineLimit(5...10)
                
                
                Button {
                    let newTransaction = TransactionEntry(amount: amount, category: category ?? TransactionCategory.defaultCategory, nameOfExpense: expenseName, description: description)
                    
                    modelCtx.insert(newTransaction)
                    onComplete()
                } label: {
                    Text("Add Transaction")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            }.navigationTitle("Add Transaction")
        }
    }
}

#Preview {
    AddNewTransaction {
        print("Should move to the next page")
    }
}
