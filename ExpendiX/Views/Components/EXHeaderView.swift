//
//  EXHeaderView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-02.
//

import SwiftUI

struct EXHeaderView: View {
    enum EXHeaderContentColor {
        case light
        case dark
    }
    
    @Environment(\.presentationMode) var presentationMode

    var title: String
    var backButtonVisible = false
    var contentColor: EXHeaderContentColor = .dark
    
    var body: some View {
        ZStack {
            if backButtonVisible {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 24))
                            .foregroundColor(contentColor == .dark ? Color("ColorDark50") : .white)
                        Spacer()
                    }
                }
            }
            
            Text(title)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(contentColor == .dark ? Color("ColorDark50") : .white)
        }
        .padding(.vertical, 16)
    }
}

struct EXHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        EXHeaderView(title: "Title")
    }
}
