//
//  EXButton.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-02.
//

import SwiftUI

struct EXButtonView: View {
    var text: String
    var isLoading = false
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Spacer()
                if isLoading {
                    ProgressView()
                        .tint(.white)
                        .padding(16)
                } else {
                    Text(text)
                        .foregroundColor(.white)
                        .padding(16)
                        .font(.system(size: 18, weight: .medium))
                }
                Spacer()
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("ColorAccent"))
        }
    }
}

struct EXButtonView_Previews: PreviewProvider {
    static var previews: some View {
        EXButtonView(text: "Login") {
            print("Hello")
        }
    }
}
