//
//  EXAddTransactionView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-10.
//

import SwiftUI

struct EXAddTransactionView: View {
    var type: EXTransactionType
    
    @StateObject var viewModel = EXAddTransactionViewViewModel()
    
    private var category: String {
        if type == .expense && viewModel.expenseCategory != nil {
            return viewModel.expenseCategory?.text ?? ""
        } else if type == .income && viewModel.incomeCategory != nil {
            return viewModel.incomeCategory?.rawValue ?? ""
        } else {
            return "Category"
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                // MARK: - HEADER
                
                VStack {
                    EXHeaderView(
                        title: "Transaction details",
                        backButtonVisible: true,
                        contentColor: .light
                    )
                    
                    HStack {
                        VStack {
                            Text(viewModel.amount)
                                .foregroundColor(.white)
                                .font(.system(size: 64, weight: .semibold))
                                .padding(.bottom, 8)
                                .keyboardType(.decimalPad)
                            Text(type == .expense ? "Expense" : "Income")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .semibold))
                                .background(content: {
                                    Capsule()
                                        .fill(type == .expense ? Color("ColorRed") : Color("ColorGreen"))
                                        .padding(-8)
                                })
                                .background(content: {
                                    Capsule()
                                        .fill(.white)
                                        .padding(-9)
                                })
                                .opacity(0.65)
                        }
                    }
                    .padding(.bottom, 32)
                    .padding(.top, 16)
                }
                .padding(.horizontal, 16)
                .background {
                    Rectangle()
                        .fill(type == .expense ? Color("ColorRed") : Color("ColorGreen"))
                        .edgesIgnoringSafeArea(.top)
                }
                
                // MARK: - INPUTS
                
                VStack(alignment: .leading) {
                    EXTextFieldView(placeholder: "Amount", value: $viewModel.amount)
                    EXTextFieldView(placeholder: "Description", value: $viewModel.description)
                    EXInputControlView(text: category) {
                        withAnimation {
                            viewModel.showExpenseCategoriesSheet.toggle()
                        }
                    }
                    EXDatePickerView(value: $viewModel.date)
                    Spacer()
                    EXButtonView(text: "Add", isLoading: viewModel.isAddingTransaction) {
                        if type == .income {
                            viewModel.addIncome()
                        } else {
                            viewModel.addExpense()
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            }
            
            // MARK: - CATEGORY SHEET
            
            EXExpenseCategorySheetView(showSheet: viewModel.showExpenseCategoriesSheet, selectCategory: { selectedCategory in
                viewModel.expenseCategory = selectedCategory as? EXExpenseCategory
            }) {
                withAnimation {
                    viewModel.showExpenseCategoriesSheet.toggle()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct EXAddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        EXAddTransactionView(type: .expense)
    }
}
