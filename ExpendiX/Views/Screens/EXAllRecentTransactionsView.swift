//
//  EXAllRecentTransactionsView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-29.
//

import SwiftUI

struct EXAllRecentTransactionsView: View {
    var type: EXTransactionType
    var incomes: [EXIncome] = []
    var expenses: [EXExpense] = []
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    EXHeaderView(title: "Recent \(type == .income ? "Incomes" : "Expenses")", backButtonVisible: true)
                    if type == .income {
                        ForEach(incomes) { income in
                            EXTransactionView(
                                type: type,
                                description: income.description,
                                date: income.date
                            )
                        }
                    } else {
                        ForEach(expenses) { expense in
                            EXTransactionView(
                                type: type,
                                description: expense.description,
                                date: expense.date
                            )
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct EXAllRecentTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        EXAllRecentTransactionsView(type: .income, incomes: [])
    }
}
