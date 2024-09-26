//
//  EditTransactionEntry.swift
//  lumen
//
//  Created by Jeremiah Lena on 26/09/2024.
//

import SwiftUI

struct EditTransactionEntry: View {
    var transaction: TransactionEntry
    var body: some View {
        Text(transaction.nameOfExpense)
            
    }
}

#Preview {
    EditTransactionEntry(transaction: TransactionEntry.defaultTransaction)
}
