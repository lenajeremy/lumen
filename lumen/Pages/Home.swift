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
    
    var sectionedTransactions: [String: [TransactionEntry]] {
        Dictionary(grouping: transactions) { transaction in
            transaction.dateCreated.formatted(date: .complete, time: .omitted)
        }
    }
    
    var body: some View {
        NavigationView {
            List{
                ForEach(sectionedTransactions.keys.sorted(), id: \.self) { date in
                    Section(header: Text(date), footer: TransactionTotalView(transactions: sectionedTransactions[date]!)) {
                        ForEach(sectionedTransactions[date]!) { transaction in
                            NavigationLink {
                                EditTransactionEntry(transaction: transaction)
                            } label: {
                                TransactionEntryView(transaction: transaction)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteEntry)
            }
            .navigationTitle("Transactions")
            .toolbar {
                EditButton()
            }
        }
    }
    
    func deleteEntry(at offsets: IndexSet) {
        for index in offsets {
            let transactionToDelete = transactions[index]
            modelContext.delete(transactionToDelete)
        }
        
        try? modelContext.save()
    }
}

struct TransactionTotalView: View {
    var transactions: [TransactionEntry]
    var total: Double {
        var sum: Double = 0
        for transaction in transactions {
            sum += transaction.amount
        }
        return sum
    }
    
    var body: some View {
        HStack {
            Text("Total: ")
                .fontWeight(.semibold)
            
            Spacer()
            
            Text(String(format: "%.2f", total))
        }
    }
}


#Preview {
    Home()
}
