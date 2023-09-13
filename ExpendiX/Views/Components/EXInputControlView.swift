//
//  EXInputControlView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-10.
//

import SwiftUI

struct EXInputControlView: View {
    var text: String
    var icon: String = "chevron.down"
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(text)
                    .foregroundColor(Color("ColorLight20"))
                    .font(.system(size: 18, weight: .regular))
                Spacer()
                Image(systemName: icon)
                    .foregroundColor(Color("ColorLight20"))
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .padding(1)
            )
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color("ColorLight60"))
            )
            .onTapGesture {
                action()
            }
        }
    }
}

struct EXInputControlView_Previews: PreviewProvider {
    static var previews: some View {
        EXInputControlView(text: "Category", icon: "chevron.down") {
            print("Hello")
        }
    }
}
