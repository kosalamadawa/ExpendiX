//
//  EXErrorMessage.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-02.
//

import SwiftUI

struct EXErrorMessage: View {
    var message: String
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
            Text(message)
                .font(.system(size: 16, weight: .regular))
        }
        .foregroundColor(.white)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background {
            Capsule()
                .fill(Color("ColorRed"))
        }
    }
}

struct EXErrorMessage_Previews: PreviewProvider {
    static var previews: some View {
        EXErrorMessage(message: "Please fill in all details")
    }
}
