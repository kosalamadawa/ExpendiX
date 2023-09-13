//
//  EXDatePickerView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-12.
//

import SwiftUI

struct EXDatePickerView: View {
    var value: Binding<Date>

    var body: some View {
        HStack {
            Text("Date")
                .foregroundColor(Color("ColorLight20"))
                .font(.system(size: 18, weight: .regular))
            
            Spacer()
            
            DatePicker("", selection: value)
                .datePickerStyle(.compact)
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

struct EXDatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        EXDatePickerView(value: .constant(Date()))
    }
}
