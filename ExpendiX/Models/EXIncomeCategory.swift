//
//  EXIncomeCategory.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-12.
//

import Foundation

enum EXIncomeCategory: String, Codable, CaseIterable {
    case salary = "salary"
    case freelance = "freelance"
    case business = "business"
    case rental = "rental"
    case investmtn = "investment"
    case interest = "interest"
    case miscellaneous = "miscellaneous"
    
    var text: String {
        return self.rawValue.capitalized
    }
}
