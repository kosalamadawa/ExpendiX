//
//  EXTransactionTypeView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-27.
//

import SwiftUI

struct EXTransactionTypeView: View {
    var type: EXTransactionType
    
    var primaryColor: Color {
        if type == .income {
            return Color("ColorGreen")
        } else {
            return Color("ColorRed")
        }
    }
    
    var secondaryColor: Color {
        if type == .income {
            return Color("ColorGreen10")
        } else {
            return Color("ColorRed10")
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: type == .income ? "arrow.down.left" : "arrow.up.right")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .foregroundColor(.white)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(primaryColor)
                        .frame(width: 30, height: 30)
                }
            Text(type == .income ? "Income" : "Expense")
                .foregroundColor(Color("ColorDark50"))
                .font(.system(size: 20, weight: .medium))
            Spacer()
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(secondaryColor)
                .padding(1)
        )
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(primaryColor)
        )
    }
}

struct EXTransactionTypeView_Previews: PreviewProvider {
    static var previews: some View {
        EXTransactionTypeView(type: .income)
            .padding()
    }
}
