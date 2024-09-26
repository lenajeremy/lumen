//
//  TransactionEntryView.swift
//  lumen
//
//  Created by Jeremiah Lena on 26/09/2024.
//

import SwiftUI

struct TransactionEntryView: View {
    var transaction: TransactionEntry
    
    var colors: [Color] = [.blue, .blue, .purple, .orange, .blue, .pink, .accentColor, .brown, .indigo, .mint, .teal]
    
    var body: some View {
        HStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 40, height: 40)
                .foregroundStyle(colors.randomElement()!)
                .overlay {
                    Image(systemName: transaction.category.icon)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(width: 20, height: 20)
                }
            VStack(alignment: .leading, spacing: 0){
                Text(transaction.nameOfExpense)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                Text(transaction.category.name)
                    .font(.subheadline)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("-$\(transaction.amount.formatted())")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                Text(transaction.dateCreated.formatted(date:.abbreviated, time: .omitted))
                    .font(.subheadline)
                    .opacity(0.8)
            }
        }
        
    }
}

#Preview {
    TransactionEntryView(transaction: TransactionEntry.defaultTransaction)
}
