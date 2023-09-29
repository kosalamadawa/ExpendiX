//
//  EXTransactionsPieChartView.swift
//  ExpendiX
//
//  Created by Kosala Rathnayake on 2023-09-26.
//

import SwiftUI
import SwiftUICharts

struct EXLegend {
    let category: String
    let amount: Double
}

struct EXTransactionsPieChartView: View {
    var type: EXTransactionType
    var totalIncomesByCategory: [EXIncomeCategory:Double] = [:]
    var totalExpensesByCategory: [EXExpenseCategory:Double] = [:]
    
    var gridLayout: [GridItem] {
        return  Array(repeating: GridItem(.flexible()), count: 2)
    }
    
    var colors: [Color] = [
        .blue,
        .red,
        .yellow,
        .green,
        .orange,
        .brown,
        .purple,
    ]
    
    var pieColors: [ColorGradient] {
        var gradients: [ColorGradient] = []
        for colorItem in colors {
            gradients.append(ColorGradient(colorItem.opacity(0.5), colorItem))
        }
        return gradients
    }
    
    var piechartData: [Double] {
        var data: [Double] = []
        if type == .expense {
            for (_, total) in totalExpensesByCategory {
                data.append(total)
            }
        } else {
            for (_, total) in totalIncomesByCategory {
                data.append(total)
            }
        }
        return data
    }
    
    var legendData: [EXLegend] {
        var legendData: [EXLegend] = []
        if type == .expense {
            for (category, total) in totalExpensesByCategory {
                legendData.append(EXLegend(category: category.text, amount: total))
            }
        } else {
            for (category, total) in totalIncomesByCategory {
                legendData.append(EXLegend(category: category.text, amount: total))
            }
        }
        return legendData
    }
    
    var body: some View {
        VStack {
            PieChart()
                .data(piechartData)
                .chartStyle(
                    ChartStyle(
                        backgroundColor: .white,
                        foregroundColor: pieColors
                    )
                )
                .frame(width: 300, height: 300)
                .padding(.vertical, 16)
            
            LazyVGrid(columns: gridLayout) {
                ForEach(0 ..< piechartData.count) { legendIndex in
                    HStack(alignment: .top) {
                        Circle()
                            .fill(colors[legendIndex])
                            .frame(width: 10)
                            .offset(y: 3)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(legendData[legendIndex].category)
                                .foregroundColor(Color("ColorLight20"))
                                .font(.system(size: 12, weight: .medium))
                            Text("\(legendData[legendIndex].amount, specifier: "%.2f")")
                                .font(.system(size: 16, weight: .medium))
                        }
                        Spacer()
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("ColorLight60"))
                    }
                }
            }
        }
    }
}

struct EXTransactionsPieChartView_Previews: PreviewProvider {
    static var previews: some View {
        EXTransactionsPieChartView(type: .expense, totalExpensesByCategory: [
            .transportation: 12000.0,
            .billsAndUtilities: 20000.0,
            .foodAndDining: 75000.0
        ])
        .padding()
    }
}
