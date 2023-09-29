//
//  EXRecentTransactionsViewViewModel.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-29.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class EXRecentTransactionsViewViewModel: ObservableObject {
    @Published var expenses: [EXExpense] = []
    @Published var incomes: [EXIncome] = []
    @Published var isLoadingExpenses = true
    @Published var isLoadingIncomes = true
    
    init() {}
    
    public func fetchData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        getExpenses(userId: userId)
        getIncomes(userId: userId)
    }
    
    private func getExpenses(userId: String) {
        isLoadingExpenses = true
        
        let db = Firestore.firestore()
        db.collection("expenses")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { [weak self] snapshot, error in
                guard let documents = snapshot?.documents, let strongSelf = self, error == nil else {
                    return
                }
                
                if documents.count > 0 {
                    var expenses: [EXExpense] = []
                    
                    for document in documents {
                        expenses.append(
                            EXExpense(
                                id: document["id"] as? String ?? "",
                                userId: document["userId"] as? String ?? "",
                                amount: document["amount"] as? Double ?? 0.0,
                                description: document["description"] as? String ?? "",
                                category: EXExpenseCategory(rawValue: document["category"] as? String ?? "") ?? .miscellaneous,
                                date: Date().timeIntervalSince1970
                            )
                        )
                    }
                    
                    DispatchQueue.main.async {
                        strongSelf.expenses = expenses
                    }
                }
                
                DispatchQueue.main.async {
                    strongSelf.isLoadingExpenses = false
                }
            }
    }
    
    private func getIncomes(userId: String) {
        isLoadingIncomes = true
        
        let db = Firestore.firestore()
        db.collection("incomes")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { [weak self] snapshot, error in
                guard let documents = snapshot?.documents, let strongSelf = self, error == nil else {
                    return
                }
                
                if documents.count > 0 {
                    var incomes: [EXIncome] = []
                    
                    for document in documents {
                        incomes.append(
                            EXIncome(
                                id: document["id"] as? String ?? "",
                                userId: document["userId"] as? String ?? "",
                                amount: document["amount"] as? Double ?? 0.0,
                                description: document["description"] as? String ?? "",
                                category: EXIncomeCategory(rawValue: document["category"] as? String ?? "") ?? .miscellaneous,
                                date: Date().timeIntervalSince1970
                            )
                        )
                    }
                    
                    DispatchQueue.main.async {
                        strongSelf.incomes = incomes
                    }
                }
                
                DispatchQueue.main.async {
                    strongSelf.isLoadingIncomes = false
                }
            }
    }
}
