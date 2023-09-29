//
//  EXEmptyStateView.swift
//  ExpendiX
//
//  Created by Sahan Walpita on 2023-09-29.
//

import SwiftUI

struct EXEmptyStateView: View {
    var image: String
    var message: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
            Text(message)
                .foregroundColor(Color("ColorLight20"))
        }
    }
}

struct EXEmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EXEmptyStateView(image: "emptyState", message: "You have not added any budget yet")
    }
}
