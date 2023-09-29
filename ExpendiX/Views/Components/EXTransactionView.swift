//
//  EXTransactionView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-29.
//

import SwiftUI

struct EXTransactionView: View {
    var type: EXTransactionType
    var description: String
    var date: TimeInterval
    
    private func getDateString(millis: TimeInterval) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: Date(timeIntervalSince1970: date))
    }

    
    var icon: String {
        if type == .income {
            return "arrow.down.left"
        } else {
            return "arrow.up.right"
        }
    }
    
    var iconBackground: Color {
        if type == .income {
            return Color("ColorGreen")
        } else {
            return Color("ColorRed")
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .foregroundColor(.white)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(iconBackground)
                        .frame(width: 30, height: 30)
                }
                .offset(y: 5)
            VStack(alignment: .leading) {
                Text(description)
                    .font(.system(size: 16, weight: .medium))
                    .lineLimit(1)
                Text(getDateString(millis: date))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color("ColorLight20"))
                    .lineLimit(1)
            }

            Spacer()
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("ColorLight60"))
                .padding(1)
        )
        .onTapGesture {
        }
    }
}

struct EXTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        EXTransactionView(
            type: .expense,
            description: "Boarding fees for son Boarding fees for son",
            date: Date().timeIntervalSince1970
        )
        .padding()
    }
}
