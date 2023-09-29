//
//  EXRecentTransactionsView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-29.
//

import SwiftUI

struct EXRecentTransactionsView: View {
    @StateObject var viewModel = EXRecentTransactionsViewViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoadingExpenses || viewModel.isLoadingIncomes {
                    ProgressView()
                        .controlSize(.large)
                } else {
                    if viewModel.expenses.count <= 0 && viewModel.incomes.count <= 0 {
                        Image("emptyTransactions")
                            .resizable()
                            .scaledToFit()
                        Text("You have not added any transactions yet")
                            .foregroundColor(Color("ColorLight20"))
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                if viewModel.expenses.count > 0 {
                                    HStack {
                                        Text("Expenses")
                                            .font(.system(size: 20, weight: .medium))
                                        Spacer()
                                        NavigationLink {
                                            EXAllRecentTransactionsView(type: .expense, expenses: viewModel.expenses)
                                        } label: {
                                            Text("View all")
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundColor(Color("ColorLight20"))
                                        }
                                    }
                                    
                                    ForEach(viewModel.expenses) { expense in
                                        EXTransactionView(
                                            type: .expense,
                                            description: expense.description,
                                            date: expense.date
                                        )
                                    }
                                }
                                
                                if viewModel.incomes.count > 0 {
                                    HStack {
                                        Text("Incomes")
                                            .font(.system(size: 20, weight: .medium))
                                        Spacer()
                                        NavigationLink {
                                            EXAllRecentTransactionsView(type: .income, incomes: viewModel.incomes)
                                        } label: {
                                            Text("View all")
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundColor(Color("ColorLight20"))
                                        }
                                    }
                                    
                                    ForEach(viewModel.incomes) { income in
                                        EXTransactionView(
                                            type: .income,
                                            description: income.description,
                                            date: income.date
                                        )
                                    }
                                }
                            }
                            .padding(16)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

struct EXRecentTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        EXRecentTransactionsView()
    }
}
