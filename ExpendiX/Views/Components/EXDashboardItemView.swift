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
    
    var bgColor: Color {
        switch type {
        case .income:
            return Color("ColorGreen10")
        case .expense:
            return Color("ColorRed10")
        case .saving:
            return Color("ColorBlue")
        }
    }
    
    var borderColor: Color {
        switch type {
        case .income:
            return Color("ColorGreen50")
        case .expense:
            return Color("ColorRed50")
        case .saving:
            return Color("ColorBlue")
        }
    }
    
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .foregroundColor(Color("ColorLight20"))
                    .font(.system(size: 16, weight: .regular))
                Text("$\(amount, specifier: "%.2f")")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold))
            }
            Spacer()
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(bgColor)
                .padding(1)
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(borderColor)
        }

    }
}

struct EXDashboardItemView_Previews: PreviewProvider {
    static var previews: some View {
        EXDashboardItemView(type: .expense, amount: 5000)
            .padding()
    }
}
