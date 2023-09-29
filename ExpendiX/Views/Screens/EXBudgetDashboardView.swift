//
//  EXBudgetDashboardView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-23.
//

import SwiftUI

struct EXBudgetDashboardView: View {
    @StateObject var viewModel = EXBudgetDashboardViewViewModel()
    
    var gridLayout: [GridItem] {
        return  Array(repeating: GridItem(.flexible()), count: 2)
    }
    
    var body: some View {
        NavigationView {
            if viewModel.isLoadingBudgets || viewModel.isLoadingExpenses {
                ProgressView()
                    .controlSize(.large)
            } else {
                if viewModel.budgetUsages.count <= 0 {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            EXHeaderView(title: "Budget Management")
                            Spacer()
                            EXEmptyStateView(
                                image: "emptyState",
                                message: "You have not added any budget yet"
                            )
                            Spacer()
                                .frame(height: 60)
                            NavigationLink {
                                EXAddBudgetView()
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("ADD BUDGET")
                                        .foregroundColor(.white)
                                        .padding(16)
                                        .font(.system(size: 18, weight: .medium))
                                    Spacer()
                                }
                                .background {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color("ColorAccent"))
                                }
                            }

                        }
                        .padding()
                    }
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            EXHeaderView(title: "Budget Management")
                            
                            HStack {
                                Text("Categories")
                                    .font(.system(size: 20, weight: .medium))
                                Spacer()
                                
                                NavigationLink {
                                    EXAddBudgetView()
                                } label: {
                                    Text("Add More")
                                        .foregroundColor(.white)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 10)
                                        .background {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color("ColorAccent"))
                                        }
                                }
                            }
                            
                            LazyVGrid(columns: gridLayout) {
                                ForEach(viewModel.budgetUsages) { budgetUsage in
                                    HStack {
                                        ProgressView(value: (budgetUsage.usedAmount/budgetUsage.budgetAmount)) {
                                            VStack(alignment: .leading, spacing: 16) {
                                                Text(budgetUsage.category.text)
                                                    .foregroundColor(Color("ColorLight20"))
                                                    .font(.system(size: 16, weight: .medium))
                                                Text("\(budgetUsage.budgetAmount, specifier: "%.2f")")
                                                    .font(.system(size: 18, weight: .semibold))
                                                    .padding(.bottom, 8)
                                            }
                                        } currentValueLabel: {
                                            Text("\(ceil((budgetUsage.usedAmount/budgetUsage.budgetAmount)*100), specifier: "%.0f") %")
                                        }
                                        .tint(budgetUsage.usedAmount > budgetUsage.budgetAmount ? .red : .green)
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color("ColorLight60"))
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    
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

struct EXBudgetDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        EXBudgetDashboardView()
    }
}
