//
//  EXExpense.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-24.
//

import Foundation

struct EXExpense: Codable, Identifiable {
    let id: String
    let userId: String
    let amount: Double
    let description: String
    let category: EXExpenseCategory
    let date: TimeInterval
}
