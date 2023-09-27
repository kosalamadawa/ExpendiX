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
            if viewModel.isLoadingData {
                ProgressView()
                    .controlSize(.large)
            } else {
                if !viewModel.isLoadingData && viewModel.budgets.count <= 0 {
                    VStack {
                        EXHeaderView(title: "Budget Management")
                        Spacer()
                        Image("emptyState")
                            .resizable()
                            .scaledToFit()
                        Text("You have not added any budget yet")
                            .foregroundColor(Color("ColorLight20"))
                        Spacer()
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
                } else {
                    ScrollView(.vertical) {
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
                                ForEach(viewModel.budgets) { budget in
                                    HStack {
                                        VStack(alignment: .leading, spacing: 16) {
                                            Text(budget.category.text)
                                                .foregroundColor(Color("ColorLight20"))
                                                .font(.system(size: 16, weight: .medium))
                                            Text("\(budget.amount, specifier: "%.2f")")
                                                .font(.system(size: 18, weight: .semibold))
                                        }
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
    }
}

struct EXBudgetDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        EXBudgetDashboardView()
    }
}
