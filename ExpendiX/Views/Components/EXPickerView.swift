//
//  EXPickerView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-23.
//

import SwiftUI

struct EXPickerView: View {
    var text: String
    var values: [String]
    var selectedValue: Binding<String>
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(Color("ColorLight20"))
                .font(.system(size: 18, weight: .regular))
            Spacer()
            Picker("", selection: selectedValue) {
                ForEach(values, id: \.self) {
                    Text(String($0))
                        .foregroundColor(Color("ColorLight20"))
                        .font(.system(size: 16))
                }
            }
            .tint(.black)
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

struct EXPickerView_Previews: PreviewProvider {
    static var previews: some View {
        EXPickerView(text: "Month", values: ["Jan"], selectedValue: .constant("May"))
    }
}
