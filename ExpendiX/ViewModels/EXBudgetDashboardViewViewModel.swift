//
//  EXBudgetDashboardViewViewModel.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class EXBudgetDashboardViewViewModel: ObservableObject {
    @Published var budgets: [EXBudget] = []
    @Published var isLoadingData = true
    @Published var showBudgetCategoriesSheet = false
    
    public func fetchData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            isLoadingData = false
            return
        }
        
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
                    strongSelf.isLoadingData = false
                    print(strongSelf.budgets)
                }
            }
    }
}
