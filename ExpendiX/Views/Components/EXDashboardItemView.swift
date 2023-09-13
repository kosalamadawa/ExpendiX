//
//  EXDashboardItem.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-03.
//

import SwiftUI

struct EXDashboardItemView: View {
    var type: EXTransactionType
    var amount: Double
    
    var icon: String {
        switch type {
        case .income:
            return "income"
        case .expense:
            return "expense"
        case .saving:
            return "income"
        }
    }
    
    var label: String {
        switch type {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        case .saving:
            return "Saving"
        }
    }
    
    var color: Color {
        switch type {
        case .income:
            return Color("ColorGreen")
        case .expense:
            return Color("ColorRed")
        case .saving:
            return Color("ColorBlue")
        }
    }
    
    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                Image(icon)
                    .padding(8)
            }
            .background {
                RoundedRectangle(cornerRadius: 14)
                    .fill(.white)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.system(size: 16, weight: .regular))
                Text("$\(amount, specifier: "%.2f")")
                    .font(.system(size: 18, weight: .medium))
            }
            .foregroundColor(.white)
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 28)
                .fill(color)
        }
    }
}

struct EXDashboardItemView_Previews: PreviewProvider {
    static var previews: some View {
        EXDashboardItemView(type: .saving, amount: 5000)
    }
}
