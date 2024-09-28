//
//  TransactionEntryView.swift
//  lumen
//
//  Created by Jeremiah Lena on 26/09/2024.
//

import SwiftUI

struct TransactionEntryView: View {
    var transaction: TransactionEntry
    var mode: SectionParameter
    
    var body: some View {
        HStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 40, height: 40)
                .foregroundStyle(Color(hex: transaction.category.colorHex) ?? .accentColor)
                .overlay {
                    Image(systemName: transaction.category.icon)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(width: 20, height: 20)
                }
            VStack(alignment: .leading){
                Text(transaction.nameOfExpense)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                
                Text(transaction.desc)
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    .lineLimit(1)
            }
            Spacer(minLength: 50)
            VStack(alignment: .trailing, spacing: 0) {
                Text(CurrencyFormatter.format(amount: transaction.amount))
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundStyle(mode == .category ? Color(hex: transaction.category.colorHex) ?? .pink : .pink)
                
                    if mode == .category {
                        HStack(spacing: 4) {
                            Circle()
                                .frame(width: 8, height: 8)
                                .foregroundStyle(Color(hex: transaction.category.colorHex) ?? .gray)
                            
                            Text(transaction.category.name)
                                .foregroundStyle(Color(hex: transaction.category.colorHex) ?? .gray)
                                .font(.subheadline)
                        }
                    } else {
                        Text(transaction.dateCreated.formatted(date:.abbreviated, time: .omitted))
                            .foregroundStyle(.gray)
                            .font(.subheadline)
                    }
            }
        }
        
    }
}

#Preview {
    TransactionEntryView(transaction: TransactionEntry.defaultTransaction, mode: .category)
}
