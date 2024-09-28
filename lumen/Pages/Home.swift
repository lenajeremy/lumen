//
//  Home.swift
//  lumen
//
//  Created by Jeremiah Lena on 26/09/2024.
//

import SwiftUI
import SwiftData

enum SectionParameter: String {
    case allMonth, allWeek, dateCreated, category
}

struct Home: View {
    @Environment(\.modelContext) private var modelContext
    @Query var transactions: [TransactionEntry]
    @State var sectionParameter: SectionParameter = .dateCreated
    
    var sectionedTransactions: [String: [TransactionEntry]] {
        switch sectionParameter {
        case .dateCreated:
            return Dictionary(grouping: transactions) { transaction in
                transaction.dateCreated.formatted(date: .complete, time: .omitted)
            }
        case .category:
            return Dictionary(grouping: transactions) { $0.category.name }
        default:
            return Dictionary(grouping: transactions) { $0.dateCreated.formatted(date: .complete, time: .omitted) }
        }
        
            }
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(sectionedTransactions.keys.sorted(), id: \.self) { key in
                    Section(header: Text(key), footer: TransactionTotalView(transactions: sectionedTransactions[key]!)) {
                        ForEach(sectionedTransactions[key]!) { transaction in
                            NavigationLink {
                                EditTransactionEntry(transaction: transaction)
                            } label: {
                                TransactionEntryView(transaction: transaction, mode: sectionParameter)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteEntry)
            }
            .navigationTitle("Transactions")
            .toolbar {
                EditButton()
                Menu {
                    Button("Date Created") {
                        sectionParameter = .dateCreated
                    }
                    Button("Category") {
                        sectionParameter = .category
                        print("Category")
                    }
                    Button("All Week") {
                        print("All week")
                    }
                    Button("All Month") {
                        print("All Month")
                    }
                } label: {
                    Label("sort by", systemImage: "line.3.horizontal.decrease.circle")
                }
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
            Text("Total:")
                .textCase(.uppercase)
            
            Spacer()
            
            Text(CurrencyFormatter.format(amount: total))
        }
        .font(.title3.weight(.semibold))
        .foregroundStyle(.primary)
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 4))
    }
}


#Preview {
    let container = setupPreviewContainer()
    
    Home()
        .modelContainer(container)
}
