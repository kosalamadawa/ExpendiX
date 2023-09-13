//
//  EXDashboardView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-03.
//

import SwiftUI

struct EXDashboardView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink {
                        EXAddTransactionView(type: .expense)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("ColorAccent"))
                    }
                }
                ScrollView {
                    VStack {
                        HStack {
                            EXDashboardItemView(type: .income, amount: 5000)
                            EXDashboardItemView(type: .expense, amount: 5000)
                        }
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct EXDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        EXDashboardView()
    }
}
