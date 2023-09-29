//
//  EXAddBudgetViewViewModel.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class EXAddBudgetViewViewModel: ObservableObject {
    @Published var amount = "0"
    @Published var budgetCategory: EXExpenseCategory?
    @Published var month = String(getCurrentMonth().prefix(3))
    @Published var year = getCurrentYear()
    @Published var showBudgetCategoriesSheet = false
    @Published var isAddingBudget = false
    
    let budgetCategories = EXExpenseCategory.allCases
    
    init () {}
    
    public func addBudget(completion: @escaping (Result<Bool, Error>) -> Void) {
        isAddingBudget = true
        
        guard isValid() else {
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid else {
            isAddingBudget = false
            return
        }
        
        let newId = UUID().uuidString
        let budget = EXBudget(
            id: newId,
            userId: userId,
            amount: Double(amount) ?? 0,
            month: month,
            year: getCurrentYear(),
            category: budgetCategory ?? .miscellaneous
        )
        
        let db = Firestore.firestore()
        db.collection("budgets")
            .document(newId)
            .setData(budget.asDictionary()) { error in
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(true))
            }
        
        isAddingBudget = false
    }
    
    private func isValid() -> Bool {
        guard Double(amount) ?? 0 > 0 else {
            return false
        }
        
        guard budgetCategory != nil else {
            return false
        }
        
        return true
    }
}
