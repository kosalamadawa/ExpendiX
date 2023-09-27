//
//  EXIncome.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-25.
//

import Foundation

struct EXIncome: Codable, Identifiable {
    let id: String
    let userId: String
    let amount: Double
    let description: String
    let category: EXIncomeCategory
    let date: TimeInterval
}
