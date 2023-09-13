//
//  EXTransaction.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-12.
//

import Foundation

protocol EXTransactionCategory: Codable {
    associatedtype ValueType
    func getValue() -> ValueType
}

extension EXExpenseCategory: EXTransactionCategory {
    typealias ValueType = EXExpenseCategory
    
    func getValue() -> EXExpenseCategory {
        return self
    }
}

extension EXIncomeCategory: EXTransactionCategory {
    typealias ValueType = EXIncomeCategory
    
    func getValue() -> EXIncomeCategory {
        return self
    }
}

struct EXTransaction<T: EXTransactionCategory>: Codable, Identifiable {
    let id: String
    let userId: String
    let amount: Double
    let description: String
    let category: T
    let date: TimeInterval
    
    init(id: String, userId: String, amount: Double, description: String, category: T, date: TimeInterval) {
        self.id = id
        self.userId = userId
        self.amount = amount
        self.description = description
        self.category = category
        self.date = date
    }
}
