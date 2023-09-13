//
//  EXExpenseCategory.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-11.
//

import Foundation

enum EXExpenseCategory: String, Codable, CaseIterable {
    case housing = "housing"
    case transportation = "transportation"
    case foodAndDining = "foodAndDining"
    case entertainment = "entertainment"
    case billsAndUtilities = "billsAndUtilities"
    case education = "education"
    case taxes = "taxes"
    case miscellaneous = "miscellaneous"
    
    var text: String {
        switch self {
        case .housing, .transportation, .education, .entertainment, .taxes, .miscellaneous:
            return rawValue.capitalized
        case .foodAndDining:
            return "Food and Dining"
        case .billsAndUtilities:
            return "Bills and Utilities"
        }
    }
}
