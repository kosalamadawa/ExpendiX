//
//  EXTextField.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-02.
//

import SwiftUI

enum EXTextFieldViewType {
    case Text
    case Secure
}

struct EXTextFieldView: View {
    var placeholder: String
    var value: Binding<String>
    var type: EXTextFieldViewType = .Text
    
    @State private var isSecured = true
    
    var body: some View {
        if type == .Text {
            ZStack {
                TextField(placeholder, text: value)
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
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
            }
        } else {
            HStack {
                if isSecured {
                    SecureField(placeholder, text: value)
                        .textInputAutocapitalization(.none)
                        .autocorrectionDisabled()
                } else {
                    TextField(placeholder, text: value)
                        .textInputAutocapitalization(.none)
                        .autocorrectionDisabled()
                }
                Image(systemName: isSecured ? "eye" : "eye.slash")
                    .foregroundColor(Color("ColorLight20"))
                    .onTapGesture {
                        isSecured.toggle()
                    }
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
        }
    }
}

struct EXTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        EXTextFieldView(placeholder: "Password", value: .constant(""))
    }
}
