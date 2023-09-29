//
//  EXAddBudgetView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-23.
//

import SwiftUI

struct EXAddBudgetView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = EXAddBudgetViewViewModel()
    
    @State private var showResponseMessage = false
    @State private var responseMessageType = EXResponseMessageType.success
    @State private var responseMessage = ""
    
    private var category: String {
        if viewModel.budgetCategory != nil {
            return viewModel.budgetCategory?.text ?? ""
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
                        title: "Budget details",
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
                            Text("Budget")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .semibold))
                                .background(content: {
                                    Capsule()
                                        .fill(.blue)
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
                        .fill(.blue)
                        .edgesIgnoringSafeArea(.top)
                }
                
                // MARK: - INPUTS
                VStack {
                    EXTextFieldView(placeholder: "Amount", value: $viewModel.amount)
                    EXInputControlView(text: category) {
                        withAnimation {
                            viewModel.showBudgetCategoriesSheet.toggle()
                        }
                    }
                    EXPickerView(
                        text: "Month",
                        values: Calendar.current.shortMonthSymbols,
                        selectedValue: $viewModel.month
                    )
                    Spacer()
                        .frame(height: 50)
                    EXButtonView(text: "ADD") {
                        viewModel.addBudget { result in
                            switch result {
                            case .success(_):
                                DispatchQueue.main.async {
                                    responseMessageType = .success
                                    responseMessage = "Data saved successfully"
                                    showResponseMessage = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    showResponseMessage = false
                                    presentationMode.wrappedValue.dismiss()
                                }
                            case .failure(let error):
                                print(error)
                                DispatchQueue.main.async {
                                    responseMessageType = .failure
                                    responseMessage = "Failed to save data"
                                    showResponseMessage = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    showResponseMessage = false
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding(16)
            }
            
            // MARK: - RESPONSE MESSAGE SHEET
            
            EXResponseMessageView(
                showSheet: showResponseMessage,
                type: responseMessageType,
                message: responseMessage
            )
            
            // MARK: - CATEGORY SHEET
            
            EXExpenseCategorySheetView(
                showSheet: viewModel.showBudgetCategoriesSheet,
                selectCategory: { selectedCategory in
                    viewModel.budgetCategory = selectedCategory as? EXExpenseCategory
                }) {
                    withAnimation {
                        viewModel.showBudgetCategoriesSheet.toggle()
                    }
                }
        }
        .navigationBarBackButtonHidden()
    }
}

struct EXAddBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        EXAddBudgetView()
    }
}
