//
//  EXHelpers.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-23.
//

import Foundation

func getCurrentMonth() -> String {
    let now = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "LLLL"
    return dateFormatter.string(from: now)
}

func getCurrentYear() -> String {
    let now = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY"
    return dateFormatter.string(from: now)
}
