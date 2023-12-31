//
//  EXDashboardView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-03.
//

import SwiftUI
import SwiftUICharts

struct EXDashboardView: View {
    @StateObject var viewModel = EXDashboardViewViewModel()
    
    var segments = ["Expenses", "Incomes"]
    @State private var selectedSegment = "Expenses"
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack(spacing: 16) {
                        Menu {
                            Button("Logout") {
                                viewModel.logout()
                            }
                        } label: {
                            Image("user")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .background {
                                    Capsule()
                                        .fill(Color("ColorLight60"))
                                        .frame(width: 45, height: 45)
                                }
                        }
                        Text("Welcome")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundColor(Color("ColorDark50"))
                        Spacer()
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("ColorAccent"))
                            .onTapGesture {
                                withAnimation {
                                    viewModel.isTransactionTypeSheetVisible.toggle()
                                }
                            }
                    }
                    
                    if !viewModel.isLoadingIncomes && !viewModel.isLoadingExpenses {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                HStack {
                                    EXDashboardItemView(type: .income, amount: viewModel.totalIncome)
                                    EXDashboardItemView(type: .expense, amount: viewModel.totalExpense)
                                }
                                
                                Picker("", selection: $selectedSegment) {
                                    ForEach(segments, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(.segmented)
                                .padding(.vertical)
                                
                                if selectedSegment == "Expenses" {
                                    if viewModel.expenses.count <= 0 {
                                        EXEmptyStateView(
                                            image: "emptyDashboard",
                                            message: "You have not added any expenses yet"
                                        )
                                    } else {
                                        EXTransactionsPieChartView(
                                            type: .expense,
                                            totalExpensesByCategory: viewModel.totalExpensesByCategory
                                        )
                                    }
                                } else {
                                    if viewModel.incomes.count <= 0 {
                                        EXEmptyStateView(
                                            image: "emptyDashboard",
                                            message: "You have not added any incomes yet"
                                        )
                                    } else {
                                        EXTransactionsPieChartView(
                                            type: .income,
                                            totalIncomesByCategory: viewModel.totalIncomesByCategory
                                        )
                                    }
                                }
                                
                                Spacer()
                            }
                        }
                    } else {
                        VStack {
                            Spacer()
                            ProgressView()
                                .controlSize(.large)
                            Spacer()
                        }
                        .padding(16)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                
                EXTransactionTypeSheetView(showSheet: viewModel.isTransactionTypeSheetVisible) {
                    viewModel.isTransactionTypeSheetVisible.toggle()
                }
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
        .refreshable {
            viewModel.fetchData()
        }
    }
}

struct EXDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        EXDashboardView()
    }
}
