//
//  EXAddTransactionViewViewModel.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-10.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class EXAddTransactionViewViewModel: ObservableObject {
    @Published var amount = "0"
    @Published var description = ""
    @Published var expenseCategory: EXExpenseCategory?
    @Published var incomeCategory: EXIncomeCategory?
    @Published var date = Date()
    @Published var showExpenseCategoriesSheet = false
    @Published var isAddingTransaction = false
    
    let expenseCategories = EXExpenseCategory.allCases
    
    init() {}
    
    public func addExpense() {
        isAddingTransaction = true
        
        guard isValid(type: .expense) else {
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid else {
            isAddingTransaction = false
            return
        }
        
        let newId = UUID().uuidString
        let transaction = EXTransaction(
            id: newId,
            userId: userId,
            amount: Double(amount) ?? 0,
            description: description,
            category: expenseCategory ?? EXExpenseCategory.miscellaneous,
            date: date.timeIntervalSince1970
        )
        
        let db = Firestore.firestore()
        db.collection("expenses")
            .document(newId)
            .setData(transaction.asDictionary())
        
        isAddingTransaction = false
    }
    
    public func addIncome() {
        let transaction = EXTransaction(
            id: "",
            userId: "",
            amount: Double(amount) ?? 0,
            description: description,
            category: incomeCategory ?? EXIncomeCategory.miscellaneous,
            date: date.timeIntervalSince1970
        )
        
        print(transaction)
    }
    
    private func isValid(type: EXTransactionType) -> Bool {
        guard !description.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        guard Double(amount) ?? 0 > 0 else {
            return false
        }
        
        if type == .expense {
            guard expenseCategory != nil else {
                return false
            }
        } else {
            guard incomeCategory != nil else {
                return false
            }
        }
        
        return true
    }
}
