//
//  EXTransactionTypeSheetView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-27.
//

import SwiftUI

struct EXTransactionTypeSheetView: View {
    var showSheet: Bool
    var closeAction: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Capsule()
                    .fill(Color("ColorLight20"))
                .frame(width: 60, height: 4)
                Text("Select Transaction type")
                    .foregroundColor(Color("ColorLight20"))
                    .font(.system(size: 16))
                
                Spacer()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        NavigationLink {
                            EXAddTransactionView(type: .income)
                        } label: {
                            EXTransactionTypeView(type: .income)
                        }

                        NavigationLink {
                            EXAddTransactionView(type: .expense)
                        } label: {
                            EXTransactionTypeView(type: .expense)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.top, 12)
            .padding(.horizontal)
            .background(Color.white.clipShape(EXCustomCorner(corners: [.topLeft, .topRight])))
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
            .offset(y: showSheet ? 0 : UIScreen.main.bounds.height * 0.5)
        }
        .frame(width: UIScreen.main.bounds.width)
        .ignoresSafeArea()
        .background(
            Color.black.opacity(showSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        closeAction()
                    }
                }
        )
    }
}

struct EXTransactionTypeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        EXTransactionTypeSheetView(showSheet: true) {
            print("ACTION")
        }
    }
}
