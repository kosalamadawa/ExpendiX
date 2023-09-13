//
//  EXTransactionCategorySheet.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-10.
//

import SwiftUI

struct EXExpenseCategorySheetView: View {
    var showSheet: Bool
    var selectCategory: (_ selectedCategory: any EXTransactionCategory) -> Void
    var closeAction: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Capsule()
                    .fill(Color("ColorLight20"))
                .frame(width: 60, height: 4)
                Text("Select Category")
                    .foregroundColor(Color("ColorLight20"))
                    .font(.system(size: 16))
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(EXExpenseCategory.allCases, id: \.self) {category in
                            HStack(spacing: 16) {
                                Image(systemName: "arrow.up.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.white)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color("ColorRed"))
                                            .frame(width: 30, height: 30)
                                    }
                                Text(category.text)
                                    .font(.system(size: 16, weight: .medium))
                                Spacer()
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
                                selectCategory(category)
                                closeAction()
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 32)
                }
            }
            .padding(.top, 12)
            .background(Color.white.clipShape(EXCustomCorner(corners: [.topLeft, .topRight])))
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
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

struct EXExpenseCategorySheetView_Previews: PreviewProvider {
    static var previews: some View {
        EXExpenseCategorySheetView(showSheet: true, selectCategory: { selectedCategory in
            print(selectedCategory)
        }) {
            print("Hello")
        }
    }
}
