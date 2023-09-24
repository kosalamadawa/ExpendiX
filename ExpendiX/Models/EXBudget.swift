//
//  EXBudget.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-23.
//

import Foundation

struct EXBudget: Codable, Identifiable {
    let id: String
    let userId: String
    let amount: Double
    let month: String
    let year: String
    let category: EXExpenseCategory
}
