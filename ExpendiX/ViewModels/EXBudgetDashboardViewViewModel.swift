//
//  EXBudgetDashboardViewViewModel.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct EXBudgetUsage: Codable, Identifiable {
    var id: String
    let category: EXExpenseCategory
    let budgetAmount: Double
    let usedAmount: Double
}

let dummyExpenses = [
    EXExpense(
        id: "1",
        userId: "234",
        amount: 2000.00,
        description: "Test",
        category: .transportation,
        date: Date().timeIntervalSince1970
    ),
    EXExpense(
        id: "1",
        userId: "234",
        amount: 2000.00,
        description: "Test",
        category: .transportation,
        date: Date().timeIntervalSince1970
    ),
    EXExpense(
        id: "2",
        userId: "234",
        amount: 8000.00,
        description: "Test",
        category: .billsAndUtilities,
        date: Date().timeIntervalSince1970
    ),
    EXExpense(
        id: "3",
        userId: "234",
        amount: 5000.00,
        description: "Test",
        category: .entertainment,
        date: Date().timeIntervalSince1970
    ),
    EXExpense(
        id: "4",
        userId: "234",
        amount: 20000.00,
        description: "Test",
        category: .housing,
        date: Date().timeIntervalSince1970
    ),
    EXExpense(
        id: "5",
        userId: "234",
        amount: 55000.00,
        description: "Test",
        category: .foodAndDining,
        date: Date().timeIntervalSince1970
    ),
]

let dummyBudgets = [
    EXBudget(
        id: "1",
        userId: "123",
        amount: 20000.0,
        month: "Sept",
        year: "2023",
        category: .transportation
    )
]

final class EXBudgetDashboardViewViewModel: ObservableObject {
    @Published var budgets: [EXBudget] = []
    @Published var expenses: [EXExpense] = []
    @Published var isLoadingBudgets = true
    @Published var isLoadingExpenses = true
    @Published var showBudgetCategoriesSheet = false
    
    var budgetUsages: [EXBudgetUsage] {
        if !isLoadingBudgets && !isLoadingExpenses {
            var usage: [EXBudgetUsage] = []
            let totalExpensesByCategory = expenses.reduce(into: [EXExpenseCategory:Double]()) { partialResult, expense in
                partialResult[expense.category, default: 0.0] += expense.amount
            }
            
            for budget in budgets {
                usage.append(
                    EXBudgetUsage(
                        id: budget.category.rawValue,
                        category: budget.category,
                        budgetAmount: budget.amount,
                        usedAmount: totalExpensesByCategory[budget.category] ?? 0
                    )
                )
            }
            
            return usage
        }
        return []
    }
    
    public func fetchData() {
        isLoadingBudgets = true
        isLoadingExpenses = true
        
        guard let userId = Auth.auth().currentUser?.uid else {
            isLoadingBudgets = false
            isLoadingExpenses = false
            return
        }
        
        getBudgets(userId: userId)
        getExpenses(userId: userId)
    }
    
    private func getBudgets(userId: String) {
        let db = Firestore.firestore()
        db.collection("budgets")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { [weak self] snapshot, error in
                guard let documents = snapshot?.documents, let strongSelf = self, error == nil else {
                    return
                }

                DispatchQueue.main.async {
                    for document in documents {
                        let budget = EXBudget(
                            id: document["id"] as? String ?? "",
                            userId: document["userId"] as? String ?? "",
                            amount: document["amount"] as? Double ?? 0,
                            month: document["month"] as? String ?? "",
                            year: document["year"] as? String ?? "",
                            category: EXExpenseCategory(rawValue: document["category"] as! String) ?? .miscellaneous
                        )
                        strongSelf.budgets.append(budget)
                    }
                    strongSelf.isLoadingBudgets = false
                    print(strongSelf.budgets)
                }
            }
    }
    
    private func getExpenses(userId: String) {
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
                        strongSelf.isLoadingExpenses = false
                    }
                }
            }
    }
}
