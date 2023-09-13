//
//  EXCustomCorner.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-10.
//

import SwiftUI

struct EXCustomCorner: Shape {
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: 32, height: 32)
        )
        return Path(path.cgPath)
    }
}

