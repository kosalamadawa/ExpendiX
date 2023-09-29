//
//  EXResponseMessageView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-29.
//

import SwiftUI

enum EXResponseMessageType {
    case success
    case failure
}

struct EXResponseMessageView: View {
    var showSheet: Bool
    var type: EXResponseMessageType
    var message: String
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Image(systemName: type == .success ? "checkmark.seal.fill" : "xmark.seal.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(type == .success ? Color("ColorGreen") : .red)
                
                Text(message)
                    .foregroundColor(Color("ColorLight20"))
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
            }
            .padding(32)
            .background(Color.white.clipShape(EXCustomCorner(corners: [.allCorners])))
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.8)
            .opacity(showSheet ? 1 : 0)
        }
        .frame(width: UIScreen.main.bounds.width)
        .ignoresSafeArea()
        .background(
            Color.black.opacity(showSheet ? 0.3 : 0).ignoresSafeArea()
        )
    }
}

struct EXResponseMessageView_Previews: PreviewProvider {
    static var previews: some View {
        EXResponseMessageView(showSheet: true, type: .failure, message: "Data saved successfully")
    }
}
