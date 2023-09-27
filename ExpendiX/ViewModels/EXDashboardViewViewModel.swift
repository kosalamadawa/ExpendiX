//
//  EXDashboardViewViewModel.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class EXDashboardViewViewModel: ObservableObject {
    @Published var totalExpense = 0.0
    @Published var totalIncome = 0.0
    @Published var expenses: [EXExpense] = []
    @Published var incomes: [EXIncome] = []
    @Published var isLoadingExpenses = true
    @Published var isLoadingIncomes = true
    
    init() {}
    
    public func fetchData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        getTotalExpense(userId: userId)
        getTotalIncome(userId: userId)
    }
    
    private func getTotalExpense(userId: String) {
//        let currentYear = getCurrentYear()
//        let currentMonth = Calendar.current.component(.month, from: Date())
//        
//        let calendar = Calendar.current
//        let startOfMonth = calendar.date(from: DateComponents(year: Int(currentYear), month: currentMonth, day: 1))!
//        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
//        
//        print(startOfMonth.timeIntervalSince1970)
//        print(endOfMonth.timeIntervalSince1970)
        
        let db = Firestore.firestore()
        db.collection("expenses")
            .whereField("userId", isEqualTo: userId)
//            .whereField("date", isGreaterThanOrEqualTo: startOfMonth.timeIntervalSince1970)
//            .whereField("date", isLessThanOrEqualTo: endOfMonth.timeIntervalSince1970)
            .getDocuments { [weak self] snapshot, error in
                guard let documents = snapshot?.documents, let strongSelf = self, error == nil else {
                    return
                }
                
                if documents.count > 0 {
                    var total = 0.0
                    var expenses: [EXExpense] = []
                    
                    for document in documents {
                        total += document["amount"] as? Double ?? 0
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
                        strongSelf.totalExpense = total
                        strongSelf.expenses = expenses
                    }
                }
                
                DispatchQueue.main.async {
                    strongSelf.isLoadingExpenses = false
                }
            }
    }
    
    private func getTotalIncome(userId: String) {
//        let currentYear = getCurrentYear()
//        let currentMonth = Calendar.current.component(.month, from: Date())
//
//        let calendar = Calendar.current
//        let startOfMonth = calendar.date(from: DateComponents(year: Int(currentYear), month: currentMonth, day: 1))!
//        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        
        let db = Firestore.firestore()
        db.collection("incomes")
            .whereField("userId", isEqualTo: userId)
//            .whereField("date", isGreaterThanOrEqualTo: startOfMonth)
//            .whereField("date", isLessThanOrEqualTo: endOfMonth)
            .getDocuments { [weak self] snapshot, error in
                guard let documents = snapshot?.documents, let strongSelf = self, error == nil else {
                    return
                }
                
                if documents.count > 0 {
                    var total = 0.0
                    var incomes: [EXIncome] = []
                    
                    for document in documents {
                        total += document["amount"] as? Double ?? 0
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
                        strongSelf.totalIncome = total
                        strongSelf.incomes = incomes
                    }
                }
                
                DispatchQueue.main.async {
                    strongSelf.isLoadingIncomes = false
                }
            }
    }
    
    let dummyIncomes = [
        EXIncome(
            id: "1",
            userId: "123",
            amount: 50000.00,
            description: "Test",
            category: .salary,
            date: Date().timeIntervalSince1970
        ),
        EXIncome(
            id: "2",
            userId: "123",
            amount: 60000.00,
            description: "Test",
            category: .business,
            date: Date().timeIntervalSince1970
        ),
        EXIncome(
            id: "3",
            userId: "123",
            amount: 70000.00,
            description: "Test",
            category: .freelance,
            date: Date().timeIntervalSince1970
        ),
        EXIncome(
            id: "4",
            userId: "123",
            amount: 80000.00,
            description: "Test",
            category: .salary,
            date: Date().timeIntervalSince1970
        )
    ]

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
}
